part of 'meals_bloc.dart';

abstract class MealsEvent extends Equatable {
  const MealsEvent();

  @override
  List<Object> get props => [];
}

class FetchMeals extends MealsEvent {
  final String category;
  const FetchMeals(this.category);
}

class SearchMeal extends MealsEvent {
  final String query;
  const SearchMeal(this.query);
}

class MealsLoadedEvent extends MealsEvent {
  final List<Meal> meals;

  MealsLoadedEvent(this.meals);
}
