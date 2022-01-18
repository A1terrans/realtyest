import 'dart:async';

import 'package:realtyest/feature/domain/entities/real_entity.dart';
import 'package:realtyest/feature/domain/usecases/get_saved_objects.dart';

enum CacheEvents { cacheLoad, cacheLoaded }

class CacheBloc {
  final GetSavedObjects getSavedObjects;
  final _eventController = StreamController<CacheEvents>();
  Stream<CacheEvents> get eventStream => _eventController.stream;
  Sink<CacheEvents> get eventSink => _eventController.sink;
  List<RealEntity> data = [];
  final _dataController = StreamController<List<RealEntity>>();
  Stream<List<RealEntity>> get dataStream => _dataController.stream;
  Sink<List<RealEntity>> get dataSink => _dataController.sink;
  CacheBloc(this.getSavedObjects) : super() {
    eventStream.listen((event) async {
      if (event == CacheEvents.cacheLoad) {
        final failureOrObject = await getSavedObjects(const PageEmptyParams());
        data = [];
        dataSink.add(data);
        failureOrObject.fold((error) => {}, (objects) {
          data.addAll(objects);
        });
        dataSink.add(data);
        eventSink.add(CacheEvents.cacheLoaded);
      }
    });
  }

  void removeCached(int id) {
    getSavedObjects.realRepository.removeObjectId(id);
    eventSink.add(CacheEvents.cacheLoad);
  }

  void addObjectToCache(RealEntity object) {
    getSavedObjects.realRepository.saveObjectToCache(object);
    eventSink.add(CacheEvents.cacheLoad);
  }

  void dispose() {
    _eventController.close();
    _dataController.close();
  }
}
