import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtyest/feature/presentation/bloc/object_list_cubit/object_list_cubit.dart';
import 'package:realtyest/feature/presentation/bloc/object_list_cubit/object_list_state.dart';
import 'package:realtyest/feature/presentation/pages/search_form_page.dart';
import 'package:realtyest/feature/presentation/widgets/objects_list_widget.dart';

import 'object_cached_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String sort = 'PriceMinToMax';

  @override
  Widget build(BuildContext context) {
    void clearList() {
      BlocProvider.of<ObjectListCubit>(context).emit(ClearObject());
      BlocProvider.of<ObjectListCubit>(context).loadObject(sort: sort);
    }

    void choiceAction(String choice) {
      if (choice == Sort.FirstItem) {
        setState(() {
          sort = 'PriceMinToMax';
        });
        clearList();
      } else if (choice == Sort.SecondItem) {
        setState(() {
          sort = 'PriceMaxToMin';
        });
        clearList();
      } else if (choice == Sort.ThirdItem) {
        setState(() {
          sort = 'AreaMinToMax';
        });
        clearList();
      } else if (choice == Sort.FourItem) {
        setState(() {
          sort = 'AreaMaxToMin';
        });
        clearList();
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchFormPage()),
              );
            },
            icon: const Icon(Icons.search)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ObjectsCachedListScreen()),
                );
              },
              icon: Icon(Icons.card_travel_outlined)),
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Sort.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        title: const Text(
          'Недвижимость СПб',
        ),
      ),
      body: ObjectsList(sort: sort),
    );
  }
}

class Sort {
  static const String FirstItem = 'Цена △';
  static const String SecondItem = 'Цена ▽';
  static const String ThirdItem = 'Площадь △';
  static const String FourItem = 'Площадь ▽';

  static const List<String> choices = <String>[
    FirstItem,
    SecondItem,
    ThirdItem,
    FourItem,
  ];
}
