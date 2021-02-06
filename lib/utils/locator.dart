import 'package:food_bloc/services/database_service.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../services/api_service.dart';

GetIt getIt = GetIt.instance;

void setUpLocator() {
  getIt.registerLazySingleton(() => DatabaseService());
  getIt.registerLazySingleton(() => ApiService(http.Client()));
}
