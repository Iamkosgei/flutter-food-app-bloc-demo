import 'dart:async';

import 'package:flutter/foundation.dart' as found;
import 'package:food_bloc/models/category.dart';
import 'package:food_bloc/models/meals.dart';
import 'package:food_bloc/services/api_service.dart';
import 'package:food_bloc/services/database_service.dart';
import 'package:food_bloc/utils/locator.dart';

class MealsRepo {
  final StreamController<Meal> mealDetailsController =
      StreamController<Meal>.broadcast();

  final StreamController<List<Meal>> mealsController =
      StreamController<List<Meal>>.broadcast();
  final StreamController<List<Category>> categoriesController =
      StreamController<List<Category>>.broadcast();

  final ApiService apiService;
  MealsRepo(this.apiService) : assert(apiService != null);

  var databaseService = getIt.get<DatabaseService>();

  Stream<List<Meal>> getMealsInCategory(String category) {
    databaseService.getMealsInCategory(category).then((cachedCategories) {
      if (cachedCategories.isNotEmpty) {
        mealsController.add(cachedCategories);
      }
      apiService.fetchMeals(category).then((newCategories) {
        if (newCategories.length != cachedCategories.length) {
          mealsController.add(newCategories);
          databaseService.deleteAllMealsInCategory(category).then(
              (value) => databaseService.insertMultipleMeals(newCategories));
        }
      });
    });
    return mealsController.stream;
  }

  Stream<Meal> getMealDetails(String id) {
    databaseService.getMeal(int.parse(id)).then((cachedMeal) {
      if (cachedMeal != null) {
        if (cachedMeal.strInstructions != null || cachedMeal.strTags != null) {
          mealDetailsController.add(cachedMeal);
        }
      }

      apiService.getMealDetails(id).then((meal) {
        if (meal != cachedMeal) {
          mealDetailsController.add(meal);
          //cache
          databaseService.addMeal(meal);
        }
      });
    });

    return mealDetailsController.stream;
  }

  Stream<List<Category>> getCategories() {
    databaseService.getCategories().then((cachedCategories) {
      if (cachedCategories.isNotEmpty) {
        categoriesController.add(cachedCategories);
      }

      apiService.getCategories().then((newCategories) {
        if (!found.listEquals(newCategories, cachedCategories)) {
          databaseService.deleteAllCategories().then((value) =>
              databaseService.insertMultipleCategories(newCategories));

          categoriesController.add(newCategories);
        }
      });
    });

    return categoriesController.stream;
  }
}
