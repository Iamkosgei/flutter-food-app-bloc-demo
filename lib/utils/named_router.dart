import 'package:flutter/material.dart';
import 'package:food_bloc/models/meals.dart';
import 'package:food_bloc/ui/pages/home_page.dart';
import 'package:food_bloc/ui/pages/meals_details_page.dart';
import 'package:food_bloc/ui/pages/meals_page.dart';

import '../utils.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Utils.HOME:
      return MaterialPageRoute(builder: (context) => CategoryPage());
    case Utils.CATEGORY:
      final String category = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => MealsPage(
                category: category,
              ));
    case Utils.MEAL_DETAILS:
      final Meal meal = settings.arguments as Meal;
      return MaterialPageRoute(
          builder: (context) => MealsDetailsPage(
                meal: meal,
              ));
    default:
      return MaterialPageRoute(builder: (context) => CategoryPage());
  }
}
