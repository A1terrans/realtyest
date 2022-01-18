// ignore_for_file: constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtyest/core/error/failure.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';
import 'package:realtyest/feature/domain/usecases/search_objects.dart';
import 'package:realtyest/feature/presentation/bloc/search_cubit/search_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache failure';

class SearchCubit extends Cubit<SearchState> {
  final SearchObject getAllObjects;
  SearchCubit({required this.getAllObjects}) : super(SearchEmpty());
  int page = 0;

  void searchObject({sort, otd, typesthree, metro, rooms}) async {
    if (state is SearchLoading) {
      print("Loading");
      return;
    }
    final currentState = state;
    var oldObject = <RealEntity>[];
    if (currentState is SearchLoaded) {
      oldObject = currentState.objects;
      print("Loaded");
    }
    if (currentState is ClearSearch) {
      oldObject.clear();
      page = 0;
    }
    emit(SearchLoading(oldObject, isFirstFetch: page == 0));
    final failureOrObject = await getAllObjects(SearchObjectParams(
      otd: otd,
      typesthree: typesthree,
      metro: metro,
      rooms: rooms,
      page: page,
      sort: sort,
    ));
    failureOrObject.fold(
        (error) => emit(SearchError(message: _mapFailureToMessage(error))),
        (object) {
      page += 10;
      final objects = (state as SearchLoading).oldObjectsList;
      objects.addAll(object);
      print('List length: ${objects.length.toString()}');
      emit(SearchLoaded(objects: objects));
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
