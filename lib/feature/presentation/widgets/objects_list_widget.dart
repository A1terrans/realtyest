import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';
import 'package:realtyest/feature/presentation/bloc/object_list_cubit/object_list_cubit.dart';
import 'package:realtyest/feature/presentation/bloc/object_list_cubit/object_list_state.dart';
import 'package:realtyest/feature/presentation/widgets/object_card_widget.dart';

class ObjectsList extends StatelessWidget {
  final scrollController = ScrollController();
  final int page = -1;
  String sort;
  List<RealEntity> objects = [];
  ObjectsList({Key? key, required this.sort}) : super(key: key);
  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<ObjectListCubit>(context).loadObject(sort: sort);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<ObjectListCubit, ObjectState>(builder: (context, state) {
      bool isLoading = false;
      if (state is ObjectLoading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is ObjectLoading) {
        objects = state.oldObjectsList;
        isLoading = true;
      } else if (state is ObjectsLoaded) {
        objects = state.objectsList;
      } else if (state is ObjectError) {
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
    });
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
