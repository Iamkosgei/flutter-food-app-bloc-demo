class Meals {
  List<Meal> meals;

  Meals({this.meals});

  Meals.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = List<Meal>();
      json['meals'].forEach((v) {
        meals.add(new Meal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meals != null) {
      data['meals'] = this.meals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meal {
  String strMeal;
  String strMealThumb;
  String idMeal;

  Meal({this.strMeal, this.strMealThumb, this.idMeal});

  Meal.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strMeal'] = this.strMeal;
    data['strMealThumb'] = this.strMealThumb;
    data['idMeal'] = this.idMeal;
    return data;
  }
}
