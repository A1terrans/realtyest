import 'dart:ffi';

import 'package:realtyest/core/error/exception.dart';
import 'package:realtyest/core/platform/network_info.dart';
import 'package:realtyest/feature/data/datasources/real_loc_data_sources.dart';
import 'package:realtyest/feature/data/datasources/real_rem_data_source.dart';
import 'package:realtyest/feature/data/models/real_model.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';
import 'package:realtyest/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:realtyest/feature/domain/repositories/real_repository.dart';

class RealRepositoryImpl implements RealRepository {
  final RealRemoteDataSource remoteDataSource;
  final RealLocalDataSource realLocalDataSource;
  final NetworkInfo networkInfo;

  RealRepositoryImpl(
      {required this.remoteDataSource,
      required this.realLocalDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<RealEntity>>> getAllObjects(
      int page, String sort) async {
    return await _getObjects(() {
      return remoteDataSource.getAllObjects(page, sort);
    });
  }

  @override
  Future<Either<Failure, List<RealEntity>>> searchObjects(
      String otd,
      String typesthree,
      String metro,
      String rooms,
      int page,
      String sort) async {
    return await _getObjects(() {
      return remoteDataSource.searchObjects(
          otd, typesthree, metro, rooms, page, sort);
    });
  }

  Future<Either<Failure, List<RealObjModel>>> _getObjects(
      Future<List<RealObjModel>> Function() getObjects) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteObject = await getObjects();
        realLocalDataSource.objectsToCache(remoteObject);
        return Right(remoteObject);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localObject = await realLocalDataSource.getLastPersonsFromCache();
        return Right(localObject);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<RealEntity>>> getSavedObjects() async {
    return await _getSavedObjects();
  }

  @override
  Future<Either<Failure, String>> removeObjectId(int id) async {
    try {
      final localObject = await realLocalDataSource.removeObjectFromCache(id);
      return const Right('success');
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> saveObjectToCache(RealEntity object) async {
    try {
      final localObject = await realLocalDataSource.objectToCache(RealObjModel(
          ID: object.ID,
          pageNow: object.pageNow,
          pagesAll: object.pagesAll,
          Types: object.Types,
          Region: object.Region,
          District: object.District,
          Address: object.Address,
          Lat: object.Lat,
          Lon: object.Lon,
          Metro: object.Metro,
          MetroTime: object.MetroTime,
          Price: object.Price,
          BasePrice: object.BasePrice,
          AllS: object.AllS,
          LiveS: object.LiveS,
          KitchenS: object.KitchenS,
          TypeTwo: object.TypeTwo,
          TypeThree: object.TypeThree,
          FloorN: object.FloorN,
          AllFloors: object.AllFloors,
          Rooms: object.Rooms,
          Apart: object.Apart,
          Stud: object.Stud,
          Year: object.Year,
          Queye: object.Queye,
          BuildType: object.BuildType,
          BuildSection: object.BuildSection,
          Contacts: object.Contacts,
          RoomsArea: object.RoomsArea,
          Image: object.Image));
      return Right('success');
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, List<RealObjModel>>> _getSavedObjects() async {
    try {
      List<RealObjModel> tempObject = [];
      final List<RealObjModel> localObject =
          tempObject + await realLocalDataSource.savedObjectsFromCache();
      return Right(localObject);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
