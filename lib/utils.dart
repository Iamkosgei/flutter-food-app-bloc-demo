import 'dart:math';

class Utils {
  static const List<String> SUGGESTIONS = [
    "Beef",
    "Pork",
    "Chicken",
  ];

  String getRandomWordFromList() {
    Random rnd = new Random();
    int min = 0;
    int max = SUGGESTIONS.length;
    return SUGGESTIONS[min + rnd.nextInt(max - min)];
  }

  static const SEARCH_CATEGORY_KEY = "search_category";
  static const String DB_NAME = 'food_database.db';
  static const String MEAL_TABLE = 'meal';
  static const String CATEGORY_TABLE = 'category';

  //routes
  static const HOME = "/";
  static const CATEGORY = "category";
  static const MEAL_DETAILS = "details";
}
