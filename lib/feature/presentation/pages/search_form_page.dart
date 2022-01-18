import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtyest/feature/presentation/bloc/search_cubit/search_cubit.dart';
import 'package:realtyest/feature/presentation/bloc/search_cubit/search_state.dart';
import 'package:realtyest/feature/presentation/pages/search_result_page.dart';
import 'package:realtyest/locator_service.dart';

class SearchFormPage extends StatelessWidget {
  const SearchFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Недвижимость СПб'),
      ),
      body: const SearchWidget(),
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _sort = TextEditingController();
  final _otd = TextEditingController();
  final _typesthree = TextEditingController();
  final _metro = TextEditingController();
  final _rooms = TextEditingController();
  SearchFields newSearch = SearchFields();
  @override
  void dispose() {
    // TODO: implement dispose
    _sort.dispose();
    _otd.dispose();
    _typesthree.dispose();
    _metro.dispose();
    _rooms.dispose();
  }

  final List<String> _sorts = [
    "Цена △",
    "Цена ▽",
    "Площадь △",
    "Площадь ▽",
  ];
  final List<String> _metros = [
    "Любая",
    "Ладожская",
    "пр. Просвещения",
    "Звездная",
    "Фрунзенская",
    "Приморская",
    "Ломоносовская",
    "Московская",
    "Комендантский пр.",
    "Лесная",
    "Удельная",
    "Автово",
    "ул. Дыбенко",
    "Обводный канал",
    "пр. Ветеранов",
    "Парнас",
    "Девяткино",
    "пр. Большевиков",
    "Старая Деревня"
  ];
  final List<String> _room = [
    "Нет",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
  ];
  final List<String> _otds = [
    "Нет",
    "черновая отделка",
    "с отделкой",
  ];
  final List<String> _typesthrees = [
    "Нет",
    "Квартира",
    "Коммерческое помещение",
  ];
  String? _selectedOtds;
  String? _selectedSort;
  String? _selectedMetro;
  String? _selectedRoom;
  String? _selectedTypesThree;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.sort),
                labelText: 'Сортировка',
              ),
              items: _sorts
                  .map((sort) => DropdownMenuItem(
                        child: Text(sort),
                        value: sort,
                      ))
                  .toList(),
              onChanged: (sort) {
                setState(() {
                  _selectedSort = sort.toString();
                  switch (_selectedSort) {
                    case "Цена △":
                      {
                        newSearch.sort = "PriceMinToMax";
                      }
                      break;
                    case "Цена ▽":
                      {
                        newSearch.sort = "PriceMaxToMin";
                      }
                      break;
                    case "Площадь △":
                      {
                        newSearch.sort = "AreaMinToMax";
                      }
                      break;
                    case "Площадь ▽":
                      {
                        newSearch.sort = "AreaMaxToMin";
                      }
                      break;
                  }
                });
              },
              value: _selectedSort,
              //validator: (val) {return val == null ? 'Please select a country' : null;},
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Image.asset('assets/images/metroTwo.png',
                    width: 25, height: 25),
                labelText: 'Метро',
              ),
              items: _metros
                  .map((metro) => DropdownMenuItem(
                        child: Text(metro),
                        value: metro,
                      ))
                  .toList(),
              onChanged: (metro) {
                setState(() {
                  _selectedMetro = metro.toString();
                  if (_selectedMetro == "Любая") {
                    newSearch.metro = "NO";
                  } else {
                    newSearch.metro = metro.toString();
                  }
                });
              },
              value: _selectedMetro,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(
                  Icons.living_outlined,
                ),
                labelText: 'Комнат',
              ),
              items: _room
                  .map((room) => DropdownMenuItem(
                        child: Text(room),
                        value: room,
                      ))
                  .toList(),
              onChanged: (room) {
                setState(() {
                  _selectedRoom = room.toString();
                  if (_selectedRoom == "Нет") {
                    newSearch.rooms = "NO";
                  } else {
                    newSearch.rooms = room.toString();
                  }
                });
              },
              value: _selectedRoom,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(
                  Icons.format_paint_outlined,
                ),
                labelText: 'Отделка',
              ),
              items: _otds
                  .map((otds) => DropdownMenuItem(
                        child: Text(otds),
                        value: otds,
                      ))
                  .toList(),
              onChanged: (otds) {
                setState(() {
                  _selectedOtds = otds.toString();
                  if (_selectedOtds == "Нет") {
                    newSearch.otd = "NO";
                  } else {
                    newSearch.otd = otds.toString();
                  }
                });
              },
              value: _selectedOtds,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(
                  Icons.meeting_room_outlined,
                ),
                labelText: 'Тип',
              ),
              items: _typesthrees
                  .map((typesthree) => DropdownMenuItem(
                        child: Text(typesthree),
                        value: typesthree,
                      ))
                  .toList(),
              onChanged: (typesthree) {
                setState(() {
                  _selectedTypesThree = typesthree.toString();
                  if (_selectedTypesThree == "Нет") {
                    newSearch.typesthree = "NO";
                  } else {
                    newSearch.typesthree = typesthree.toString();
                  }
                });
              },
              value: _selectedTypesThree,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 100,
              height: 40.0,
              child: MaterialButton(
                child: Text('Найти', style: TextStyle(color: Colors.white)),
                color: Colors.red,
                onPressed: _submitForm,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      BlocProvider.of<SearchCubit>(context).emit(ClearSearch());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchPage(
            fields: newSearch,
          ),
        ),
      );
    } else {
      _showMessage(message: 'Ошибка в заполнении формы');
    }
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 5),
      content: Text(
        message,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      backgroundColor: Colors.red,
    ));
  }
}

class SearchFields {
  String sort = 'PriceMinToMax';
  String otd = 'NO';
  String typesthree = 'NO';
  String metro = 'NO';
  String rooms = 'NO';
}
