import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:realtyest/core/error/failure.dart';
import 'package:realtyest/core/usecases/usecase.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';
import 'package:realtyest/feature/domain/repositories/real_repository.dart';

class GetSavedObjects extends UseCase<List<RealEntity>, PageEmptyParams> {
  final RealRepository realRepository;
  GetSavedObjects(this.realRepository);
  @override
  Future<Either<Failure, List<RealEntity>>> call(PageEmptyParams params) async {
    return await realRepository.getSavedObjects();
  }
}

class PageEmptyParams extends Equatable {
  const PageEmptyParams();
  @override
  List<Object?> get props => [];
}
