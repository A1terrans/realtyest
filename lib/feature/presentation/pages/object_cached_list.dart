import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';
import 'package:realtyest/feature/presentation/bloc/cached_bloc/cached_bloc.dart';
import 'package:realtyest/feature/presentation/widgets/object_card_widget.dart';

final sl = GetIt.instance;

class ObjectsCachedListScreen extends StatelessWidget {
  ObjectsCachedListScreen({Key? key}) : super(key: key);
  CacheBloc _cache = CacheBloc(sl());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
      ),
      body: CachedObjects(
        cache: _cache,
      ),
    );
  }
}

//class ObjectsCachedListScreen extends StatefulWidget {
//  const ObjectsCachedListScreen({Key? key}) : super(key: key);
//
//  @override
//  _ObjectsCachedListScreenState createState() =>
//      _ObjectsCachedListScreenState();
//}
//
//class _ObjectsCachedListScreenState extends State<ObjectsCachedListScreen> {
//  @override
//  CacheBloc _cache = CacheBloc(sl());
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Избранное'),
//      ),
//      body: CachedObjects(
//        cache: _cache,
//      ),
//    );
//  }
//
//  @override
//  void dispose() {
//    _cache.dispose();
//    super.dispose();
//  }
//}

class CachedObjects extends StatelessWidget {
  CacheBloc cache;
  CachedObjects({Key? key, required this.cache}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    cache.eventSink.add(CacheEvents.cacheLoad);
    return Container(
      child: StreamBuilder<List<RealEntity>>(
        stream: cache.dataStream,
        initialData: [],
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return ObjectCard(
                    object: snapshot.data![index],
                    favorite: true,
                    onPress: () {
                      cache.removeCached(index);
                      cache.eventSink.add(CacheEvents.cacheLoad);
                    });
              });
        },
      ),
    );
  }
}
