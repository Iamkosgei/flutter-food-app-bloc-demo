class Categories {
  List<Category> categories;

  Categories({this.categories});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = new List<Category>();
      json['categories'].forEach((v) {
        categories.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int idCategory;
  String strCategory;
  String strCategoryThumb;

  Category({this.idCategory, this.strCategory, this.strCategoryThumb});

  Category.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCategory'] is String
        ? int.parse(json['idCategory'])
        : json['idCategory'];
    strCategory = json['strCategory'];
    strCategoryThumb = json['strCategoryThumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCategory'] = this.idCategory;
    data['strCategory'] = this.strCategory;
    data['strCategoryThumb'] = this.strCategoryThumb;

    return data;
  }
}
