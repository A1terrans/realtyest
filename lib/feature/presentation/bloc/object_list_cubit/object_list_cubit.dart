// ignore_for_file: constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtyest/core/error/failure.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';
import 'package:realtyest/feature/domain/usecases/get_all_objects.dart';
import 'object_list_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache failure';

class ObjectListCubit extends Cubit<ObjectState> {
  final GetAllObjects getAllObjects;
  ObjectListCubit({required this.getAllObjects}) : super(ObjectEmpty());
  int page = 0;
  void loadObject({String sort = 'PriceMinToMax'}) async {
    if (state is ObjectLoading) return;
    final currentState = state;
    var oldObject = <RealEntity>[];
    if (currentState is ObjectsLoaded) {
      oldObject = currentState.objectsList;
    }
    if (currentState is ClearObject) {
      oldObject.clear();
      page = 0;
    }
    emit(ObjectLoading(oldObject, isFirstFetch: page == 0));
    final failureOrObject =
        await getAllObjects(PageRealParams(page: page, sort: sort));
    failureOrObject.fold(
        (error) => emit(ObjectError(message: _mapFailureToMessage(error))),
        (object) {
      page += 10;
      final objects = (state as ObjectLoading).oldObjectsList;
      objects.addAll(object);
      emit(ObjectsLoaded(objects));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
