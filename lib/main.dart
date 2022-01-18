import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtyest/feature/presentation/bloc/search_cubit/search_cubit.dart';
import 'common/fonts.dart';
import 'feature/presentation/bloc/object_list_cubit/object_list_cubit.dart';
import 'feature/presentation/pages/object_list_screen.dart';
import 'locator_service.dart' as di;
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const RealApp());
}

class RealApp extends StatelessWidget {
  const RealApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ObjectListCubit>(
              create: (context) => sl<ObjectListCubit>()..loadObject()),
          BlocProvider<SearchCubit>(create: (context) => sl<SearchCubit>()),
        ],
        child: MaterialApp(
          title: 'Недвижимость СПб',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey.shade100,
            appBarTheme: AppBarTheme(
              color: Colors.red,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  color: Colors.grey.shade50,
                  fontSize: FONT_SIZE_BIG,
                  fontWeight: FontWeight.bold),
            ),
          ),
          home: HomePage(),
        ));
  }
}
