import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:realtyest/core/error/exception.dart';
import 'package:realtyest/feature/data/models/real_model.dart';

abstract class RealRemoteDataSource {
  /// Calls the URL endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<RealObjModel>> getAllObjects(int page, String sort);
  Future<List<RealObjModel>> searchObjects(String otd, String typesthree,
      String metro, String rooms, int page, String sort);
}

class RealRemoteDataSourceImpl implements RealRemoteDataSource {
  final http.Client client;
  RealRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RealObjModel>> searchObjects(String otd, String typesthree,
          String metro, String rooms, int page, String sort) =>
      _getObjectsFromUrl(
          'http://INSERTAPIURL/api.php?metro=$metro&otd=$otd&typesthree=$typesthree&rooms=$rooms&sort=$sort&page=$page');

  @override
  Future<List<RealObjModel>> getAllObjects(
          [int page = 1, String sort = 'PriceMinToMax']) =>
      _getObjectsFromUrl(
          'http://INSERTAPIURL/api.php?page=$page&sort=$sort');

  Future<List<RealObjModel>> _getObjectsFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final objects = json.decode(response.body);
      return (objects as List)
          .map((object) => RealObjModel.fromJson(object))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
