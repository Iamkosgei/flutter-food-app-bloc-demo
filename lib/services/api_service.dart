import 'dart:convert';

import 'package:food_bloc/models/meal_details.dart' as mealDetails;
import 'package:food_bloc/models/meals.dart';
import 'package:food_bloc/utils.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  final http.Client httpClient;

  ApiService(this.httpClient) : assert(httpClient != null);

  Future<List<Meal>> fetchMeals() async {
    Utils _utils = new Utils();
    final filterByMainIngredientUrl =
        '$baseUrl/filter.php?i=${_utils.getRandomWordFromList()}';
    final response = await this.httpClient.get(filterByMainIngredientUrl);

    if (response.statusCode != 200) {
      throw Exception('error getting meals');
    }

    final mealsJson = jsonDecode(response.body);
    return Meals.fromJson(mealsJson).meals;
  }

  Future<List<Meal>> searchMeals(String query) async {
    final searchMealUrl = '$baseUrl/search.php?s=$query';
    final response = await this.httpClient.get(searchMealUrl);

    if (response.statusCode != 200) {
      throw Exception('error getting meals');
    }
    final mealsJson = jsonDecode(response.body);
    return Meals.fromJson(mealsJson).meals;
  }

  Future<mealDetails.MealDetails> getMealDetails(String id) async {
    final mealDetailsUrl = '$baseUrl/lookup.php?i=$id';

    final response = await this.httpClient.get(mealDetailsUrl);

    if (response.statusCode != 200) {
      throw Exception('error getting meal details');
    }
    final mealsDetailsJson = jsonDecode(response.body);
    return mealDetails.MealDetails.fromJson(mealsDetailsJson);
  }
}
