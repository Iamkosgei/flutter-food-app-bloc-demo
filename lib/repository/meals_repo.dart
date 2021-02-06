import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart' as found;
import 'package:food_bloc/models/category.dart';
import 'package:food_bloc/models/meals.dart';
import 'package:food_bloc/services/api_service.dart';
import 'package:food_bloc/services/database_service.dart';
import 'package:food_bloc/utils/locator.dart';

class MealsRepo {
  final ApiService apiService;
  MealsRepo(this.apiService) : assert(apiService != null);

  var databaseService = getIt.get<DatabaseService>();

  final StreamController<List<Meal>> _mealsController =
      StreamController<List<Meal>>.broadcast();

  Stream<List<Meal>> listenToMeals(String category) {
    databaseService.getMealsInCategory(category).then((cachedCategories) {
      if (cachedCategories.isNotEmpty) {
        _mealsController.add(cachedCategories);
      }
      apiService.fetchMeals(category).then((newCategories) {
        if (newCategories.length != cachedCategories.length) {
          log("changed----------");
          _mealsController.add(newCategories);
          databaseService.deleteAllMealsInCategory(category).then(
              (value) => databaseService.insertMultipleMeals(newCategories));
        }
      });
    });
    return _mealsController.stream;
  }

  Future<List<Meal>> getMeals(String category) async {
    return await apiService.fetchMeals(category);
  }

  Future<Meal> getMealDetails(String id) async {
    return await apiService.getMealDetails(id);
  }

  final StreamController<List<Category>> _categoriesController =
      StreamController<List<Category>>.broadcast();
  Stream<List<Category>> listenToCategories() {
    databaseService.getCategories().then((cachedCategories) {
      if (cachedCategories.isNotEmpty) {
        _categoriesController.add(cachedCategories);
      }

      apiService.getCategories().then((newCategories) {
        if (!found.listEquals(newCategories, cachedCategories)) {
          log("lentgh --- ${newCategories.length}");
          databaseService.deleteAllCategories().then((value) =>
              databaseService.insertMultipleCategories(newCategories));

          _categoriesController.add(newCategories);
        }
      });
    });

    return _categoriesController.stream;
  }
}
