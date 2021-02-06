import 'package:food_bloc/models/category.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/meals.dart';
import '../utils.dart';

class DatabaseService {
  Database _database;

  Future<Database> initialise() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, Utils.DB_NAME);
    _database = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return _database;
  }

  void createDb(Database database, int version) async {
    await database.execute(
        "CREATE TABLE ${Utils.MEAL_TABLE} (idMeal INTEGER PRIMARY KEY, strMeal TEXT, strCategory TEXT, strInstructions TEXT, strMealThumb TEXT, strTags TEXT);");

    await database.execute(
        "CREATE TABLE ${Utils.CATEGORY_TABLE} (idCategory INTEGER PRIMARY KEY, strCategory TEXT, strCategoryThumb TEXT);");
  }

  Future addMeal(Meal meal) async {
    try {
      await _database.insert(Utils.MEAL_TABLE, meal.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {}
  }

  Future<Meal> getMeal(int id) async {
    Meal meal;
    try {
      var res = await _database.query(Utils.MEAL_TABLE,
          where: "idMeal = ?", whereArgs: [id], limit: 1);

      if (res.length == 1) {
        meal = Meal.fromJson(res[0]);
      }
    } catch (e) {
      throw ('Could not get meal');
    }
    return meal;
  }

  Future insertMultipleMeals(List<Meal> meals) async {
    try {
      Batch batch = _database.batch();
      for (Meal meal in meals) {
        batch.insert(Utils.MEAL_TABLE, meal.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit();
    } catch (e) {}
  }

  Future deleteAllMealsInCategory(String category) async {
    try {
      await _database.delete(Utils.MEAL_TABLE,
          where: "strCategory = ?", whereArgs: [category]);
      return;
    } catch (e) {}
  }

  Future insertMultipleCategories(List<Category> categories) async {
    try {
      Batch batch = _database.batch();
      for (Category category in categories) {
        batch.insert(Utils.CATEGORY_TABLE, category.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit();
    } catch (e) {}
  }

  Future<List<Category>> getCategories() async {
    List<Category> _categories = List<Category>();
    try {
      var res = await _database.query(
        Utils.CATEGORY_TABLE,
      );

      if (res.isNotEmpty) {
        Map<String, dynamic> _resMap = {"categories": res};

        _categories = Categories.fromJson(_resMap).categories;
      }
    } catch (e) {
      throw ('Could not get categories $e');
    }
    return _categories;
  }

  Future<List<Meal>> getMealsInCategory(String category) async {
    List<Meal> _meals = List<Meal>();
    try {
      var res = await _database.query(Utils.MEAL_TABLE,
          where: "strCategory = ?", whereArgs: [category]);

      if (res.isNotEmpty) {
        Map<String, dynamic> _resMap = {"meals": res};

        _meals = Meals.fromJson(_resMap).meals;
      }
    } catch (e) {
      throw ('Could not get meal $e');
    }
    return _meals;
  }

  Future deleteAllCategories() async {
    try {
      await _database.delete(
        Utils.CATEGORY_TABLE,
      );
      return;
    } catch (e) {}
  }
}
