// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:realtyest/core/error/exception.dart';
import 'package:realtyest/feature/data/models/real_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RealLocalDataSource {
  Future<List<RealObjModel>> getLastPersonsFromCache();
  Future<void> objectsToCache(List<RealObjModel> objects);
  Future<void> objectToCache(RealObjModel object);
  Future<List<RealObjModel>> savedObjectsFromCache();
  Future<List<String>> removeObjectFromCache(int id);
}

// ignore: constant_identifier_names
const CACHED_OBJECTS_LIST = 'CACHED_OBJECTS_LIST';
const CACHED_OBJECT = 'CACHED_OBJECT';

class RealLocalDataSourceImpl implements RealLocalDataSource {
  final SharedPreferences sharedPreferences;
  RealLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<RealObjModel>> getLastPersonsFromCache() {
    final jsonRealList = sharedPreferences.getStringList(CACHED_OBJECTS_LIST);
    if (jsonRealList!.isNotEmpty) {
      return Future.value(jsonRealList
          .map((object) => RealObjModel.fromJson(json.decode(object)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> objectsToCache(List<RealObjModel> objects) {
    final List<String> jsonRealList =
        objects.map((object) => json.encode(object.toJson())).toList();
    sharedPreferences.setStringList(CACHED_OBJECTS_LIST, jsonRealList);
    return Future.value(jsonRealList);
  }

  @override
  Future<List<String>> objectToCache(RealObjModel object) {
    final String jsonReal = json.encode(object.toJson());
    List<String> cached = sharedPreferences.getStringList(CACHED_OBJECT) ?? [];
    cached.add(jsonReal);
    sharedPreferences.setStringList(CACHED_OBJECT, cached);
    return Future.value(cached);
  }

  @override
  Future<List<RealObjModel>> savedObjectsFromCache() {
    final jsonRealList = sharedPreferences.getStringList(CACHED_OBJECT);
    if (jsonRealList!.isNotEmpty) {
      return Future.value(jsonRealList
          .map((object) => RealObjModel.fromJson(json.decode(object)))
          .toList());
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<List<String>> removeObjectFromCache(int id) {
    List<String> cached = sharedPreferences.getStringList(CACHED_OBJECT) ?? [];
    cached.removeAt(id);
    sharedPreferences.setStringList(CACHED_OBJECT, cached);
    return Future.value(cached);
  }
}
