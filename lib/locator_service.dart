import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:realtyest/feature/data/datasources/real_loc_data_sources.dart';
import 'package:realtyest/feature/data/datasources/real_rem_data_source.dart';
import 'package:realtyest/feature/data/repositories/real_repository_impl.dart';
import 'package:realtyest/feature/domain/repositories/real_repository.dart';
import 'package:realtyest/feature/domain/usecases/get_all_objects.dart';
import 'package:realtyest/feature/domain/usecases/get_saved_objects.dart';
import 'package:realtyest/feature/domain/usecases/search_objects.dart';
import 'package:realtyest/feature/presentation/bloc/object_list_cubit/object_list_cubit.dart';
import 'package:realtyest/feature/presentation/bloc/search_cubit/search_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/network_info.dart';

final sl = GetIt.instance;
Future<void> init() async {
  // BLoC / Cubit
  sl.registerFactory(() => ObjectListCubit(getAllObjects: sl()));
  sl.registerFactory(() => SearchCubit(getAllObjects: sl()));
  // UseCases
  sl.registerLazySingleton(() => GetAllObjects(sl()));
  sl.registerLazySingleton(() => SearchObject(sl()));
  sl.registerLazySingleton(() => GetSavedObjects(sl()));
  // Repository
  sl.registerLazySingleton<RealRepository>(() => RealRepositoryImpl(
      remoteDataSource: sl(), realLocalDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<RealRemoteDataSource>(
      () => RealRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<RealLocalDataSource>(
      () => RealLocalDataSourceImpl(sharedPreferences: sl()));
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
