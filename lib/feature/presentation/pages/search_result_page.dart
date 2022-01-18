import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtyest/feature/data/repositories/real_repository_impl.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';
import 'package:realtyest/feature/domain/repositories/real_repository.dart';
import 'package:realtyest/feature/domain/usecases/search_objects.dart';
import 'package:realtyest/feature/presentation/bloc/search_cubit/search_cubit.dart';
import 'package:realtyest/feature/presentation/bloc/search_cubit/search_state.dart';
import 'package:realtyest/feature/presentation/pages/search_form_page.dart';
import 'package:realtyest/feature/presentation/widgets/object_card_widget.dart';

class SearchPage extends StatelessWidget {
  final SearchFields fields;
  final scrollController = ScrollController();
  final int page = -1;
  void loadData(BuildContext context) {
    BlocProvider.of<SearchCubit>(context).searchObject(
        sort: fields.sort,
        otd: fields.otd,
        typesthree: fields.typesthree,
        metro: fields.metro,
        rooms: fields.rooms);
  }

  List<RealEntity> objects = [];
  SearchPage({Key? key, required this.fields}) : super(key: key);
  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          loadData(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    loadData(context);
    setupScrollController(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Недвижимость поиск'),
        ),
        body: BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
          bool isLoading = false;
          if (state is SearchLoading && state.isFirstFetch) {
            print('first');
            return _loadingIndicator();
          } else if (state is SearchLoading) {
            objects = state.oldObjectsList;
            isLoading = true;
            print('loading');
          } else if (state is SearchLoaded) {
            objects = state.objects;
            print('loaded');
          } else if (state is SearchError) {
            print('error');
            return Text(
              state.message,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            );
          }
          return ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) {
                if (index < objects.length) {
                  return ObjectCard(object: objects[index], onPress: () {});
                } else {
                  Timer(const Duration(milliseconds: 30), () {
                    scrollController
                        .jumpTo(scrollController.position.maxScrollExtent);
                  });
                  return _loadingIndicator();
                }
              },
              separatorBuilder: (context, index) {
                return Container();
              },
              itemCount: objects.length + (isLoading ? 1 : 0));
        }));
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
