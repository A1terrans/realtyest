import 'package:dartz/dartz.dart';
import 'package:realtyest/core/error/failure.dart';
import 'package:realtyest/feature/data/models/real_model.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';

abstract class RealRepository {
  Future<Either<Failure, List<RealEntity>>> getAllObjects(
      int page, String sort);
  Future<Either<Failure, List<RealEntity>>> searchObjects(String otd,
      String typesthree, String metro, String rooms, int page, String sort);
  Future<Either<Failure, List<RealEntity>>> getSavedObjects();
  Future<Either<Failure, String>> removeObjectId(int id);
  Future<Either<Failure, String>> saveObjectToCache(RealEntity object);
}
