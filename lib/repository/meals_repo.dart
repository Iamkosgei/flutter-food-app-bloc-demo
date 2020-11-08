import 'package:food_bloc/models/meal_details.dart';
import 'package:food_bloc/models/meals.dart';
import 'package:food_bloc/services/api_service.dart';

class MealsRepo {
  final ApiService apiService;
  MealsRepo(this.apiService) : assert(apiService != null);

  Future<List<Meal>> getMeals() async {
    return await apiService.fetchMeals();
  }

  Future<List<Meal>> searchMeals(String query) async {
    return await apiService.searchMeals(query);
  }

  Future<MealDetails> getMealDetails(String id) async {
    return await apiService.getMealDetails(id);
  }
}
