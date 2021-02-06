import 'dart:convert';

import 'package:food_bloc/models/category.dart';
import 'package:food_bloc/models/meals.dart';
import 'package:food_bloc/utils/locator.dart';
import 'package:http/http.dart' as http;

import '../models/meals.dart';
import 'database_service.dart';

class ApiService {
  static const baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  final http.Client httpClient;

  var databaseService = getIt.get<DatabaseService>();

  ApiService(this.httpClient) : assert(httpClient != null);

  Future<List<Meal>> fetchMeals(String category) async {
    final filterByMainIngredientUrl = '$baseUrl/filter.php?c=$category';
    final response = await this.httpClient.get(filterByMainIngredientUrl);

    if (response.statusCode != 200) {
      throw Exception('error getting meals');
    }

    final mealsJson = jsonDecode(response.body);

    List<Meal> meals = Meals.fromJson(mealsJson).meals;

    meals = meals.map((e) {
      e.strCategory = category;
      return e;
    }).toList();

    return meals;
  }

  Future<Meal> getMealDetails(String id) async {
    try {
      Meal cachedMeal = await databaseService.getMeal(int.parse(id));

      if (cachedMeal != null) {
        if (cachedMeal.strInstructions != null || cachedMeal.strTags != null) {
          return cachedMeal;
        }
      }

      final mealDetailsUrl = '$baseUrl/lookup.php?i=$id';

      final response = await this.httpClient.get(mealDetailsUrl);

      if (response.statusCode != 200) {
        throw Exception('error getting meal details');
      }
      final mealsDetailsJson = jsonDecode(response.body);
      Meal meal = Meal.fromJson(mealsDetailsJson['meals'][0]);
      //cache
      databaseService.addMeal(meal);
      return meal;
    } catch (e) {
      throw Exception('error getting meal details');
    }
  }

  Future<List<Category>> getCategories() async {
    final categoriesUrl = '$baseUrl/categories.php';

    final response = await this.httpClient.get(categoriesUrl);

    if (response.statusCode != 200) {
      throw Exception('error getting categories');
    }
    final categoriesJson = jsonDecode(response.body);
    List<Category> categories = Categories.fromJson(categoriesJson).categories;
    //cache
    databaseService.insertMultipleCategories(categories);

    return categories;
  }
}
