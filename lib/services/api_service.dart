import 'dart:convert';

import 'package:food_bloc/models/meals.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  final http.Client httpClient;

  ApiService(this.httpClient) : assert(httpClient != null);

  Future<List<Meal>> fetchMeals() async {
    final filterByMainIngredientUrl = '$baseUrl/filter.php?i=pork';
    final response = await this.httpClient.get(filterByMainIngredientUrl);

    if (response.statusCode != 200) {
      throw Exception('error getting meals');
    }

    final mealsJson = jsonDecode(response.body);
    return Meals.fromJson(mealsJson).meals;
  }

  Future<List<Meal>> searchMeals(String query) async {
    final filterByMainIngredientUrl = '$baseUrl/search.php?s=$query';
    final response = await this.httpClient.get(filterByMainIngredientUrl);

    if (response.statusCode != 200) {
      throw Exception('error getting meals');
    }

    final mealsJson = jsonDecode(response.body);
    return Meals.fromJson(mealsJson).meals;
  }
}
