import 'package:food_bloc/models/meals.dart';
import 'package:food_bloc/services/api_service.dart';

class MealsRepo {
  final ApiService apiService;
  MealsRepo(this.apiService) : assert(apiService != null);

  Future<List<Meal>> getMeals() async {
    return await apiService.fetchMeals();
  }
}
