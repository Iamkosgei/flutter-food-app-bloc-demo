part of 'meal_category_bloc.dart';

abstract class MealCategoryState extends Equatable {
  const MealCategoryState();

  @override
  List<Object> get props => [];
}

class MealCategoryInitial extends MealCategoryState {}

class MealCategoryLoading extends MealCategoryState {}

class MealCategoryError extends MealCategoryState {}

class MealCategoryLoaded extends MealCategoryState {
  @override
  List<Category> get props => categories;
  final List<Category> categories;

  MealCategoryLoaded(this.categories) : assert(categories != null);
}
