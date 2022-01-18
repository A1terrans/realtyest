import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:realtyest/core/error/failure.dart';
import 'package:realtyest/core/usecases/usecase.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';
import 'package:realtyest/feature/domain/repositories/real_repository.dart';

class SearchObject extends UseCase<List<RealEntity>, SearchObjectParams> {
  final RealRepository realRepository;
  SearchObject(this.realRepository);
  @override
  Future<Either<Failure, List<RealEntity>>> call(
      SearchObjectParams params) async {
    return await realRepository.searchObjects(params.otd, params.typesthree,
        params.metro, params.rooms, params.page, params.sort);
  }
}

class SearchObjectParams extends Equatable {
  final String otd;
  final String typesthree;
  final String metro;
  final String rooms;
  final int page;
  final String sort;

  const SearchObjectParams(
      {this.otd = 'NO',
      this.typesthree = 'NO',
      this.metro = 'NO',
      this.rooms = 'NO',
      this.page = 1,
      this.sort = 'PriceMinToMax'});

  @override
  List<Object?> get props => [otd, typesthree, metro, rooms, page, sort];
}
