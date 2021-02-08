import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_bloc/utils.dart';

import 'blocs/meal_category/meal_category_bloc.dart';
import 'blocs/meal_details/meal_details_bloc.dart';
import 'blocs/meals/meals_bloc.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'repository/meals_repo.dart';

import 'services/api_service.dart';
import 'services/database_service.dart';
import 'utils/locator.dart';
import 'utils/named_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  setUpLocator();

  var _databaseService = getIt.get<DatabaseService>();

  var _apiService = getIt.get<ApiService>();

  await _databaseService.initialise();

  final MealsRepo mealsRepo = MealsRepo(_apiService);

  runApp(MyApp(
    mealsRepo: mealsRepo,
  ));
}

class MyApp extends StatelessWidget {
  final MealsRepo mealsRepo;

  const MyApp({Key key, @required this.mealsRepo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MealsBloc(mealsRepo: mealsRepo)),
        BlocProvider(
            create: (context) => MealDetailsBloc(mealsRepo: mealsRepo)),
        BlocProvider(
            create: (context) => MealCategoryBloc(mealsRepo: mealsRepo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Bloc Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        onGenerateRoute: generateRoute,
        initialRoute: Utils.HOME,
      ),
    );
  }
}
