import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/meal_details/meal_details_bloc.dart';
import 'blocs/meals/meals_bloc.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'repository/meals_repo.dart';
import 'services/api_service.dart';
import 'package:http/http.dart' as http;

import 'ui/pages/meals_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  final MealsRepo mealsRepo = MealsRepo(
    ApiService(
      http.Client(),
    ),
  );

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Bloc Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MealsPage(),
      ),
    );
  }
}
