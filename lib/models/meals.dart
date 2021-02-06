class Meals {
  List<Meal> meals;

  Meals({this.meals});

  Meals.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = new List<Meal>();
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
  int idMeal;
  String strMeal;
  String strCategory;
  String strInstructions;
  String strMealThumb;
  String strTags;

  Meal({
    this.idMeal,
    this.strMeal,
    this.strCategory,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
  });

  Meal.fromJson(Map<String, dynamic> json) {
    idMeal =
        json['idMeal'] is String ? int.parse(json['idMeal']) : json['idMeal'];
    strMeal = json['strMeal'];
    strCategory = json['strCategory'];
    strInstructions = json['strInstructions'];
    strMealThumb = json['strMealThumb'];
    strTags = json['strTags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idMeal'] = this.idMeal;
    data['strMeal'] = this.strMeal;
    data['strCategory'] = this.strCategory;
    data['strInstructions'] = this.strInstructions;
    data['strMealThumb'] = this.strMealThumb;
    data['strTags'] = this.strTags;

    return data;
  }

  @override
  String toString() {
    return "$strCategory";
  }
}
