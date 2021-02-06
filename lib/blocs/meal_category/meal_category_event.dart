part of 'meal_category_bloc.dart';

abstract class MealCategoryEvent extends Equatable {
  const MealCategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchCategories extends MealCategoryEvent {
  const FetchCategories();
}

class CategoriesLoaded extends MealCategoryEvent {
  final List<Category> categories;
  const CategoriesLoaded(this.categories);
}
