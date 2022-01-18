import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:realtyest/core/error/failure.dart';
import 'package:realtyest/core/usecases/usecase.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';
import 'package:realtyest/feature/domain/repositories/real_repository.dart';

class GetAllObjects extends UseCase<List<RealEntity>, PageRealParams> {
  final RealRepository realRepository;
  GetAllObjects(this.realRepository);
  @override
  Future<Either<Failure, List<RealEntity>>> call(PageRealParams params) async {
    return await realRepository.getAllObjects(params.page, params.sort);
  }
}

class PageRealParams extends Equatable {
  final int page;
  final String sort;

  const PageRealParams({required this.page, required this.sort});

  @override
  List<Object?> get props => [page, sort];
}
