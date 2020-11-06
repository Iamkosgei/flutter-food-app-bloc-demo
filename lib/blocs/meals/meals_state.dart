part of 'meals_bloc.dart';

abstract class MealsState extends Equatable {
  const MealsState();

  @override
  List<Object> get props => [];
}

class MealsInitial extends MealsState {}

class MealsLoading extends MealsState {}

class MealsError extends MealsState {}

class MealsEmpty extends MealsState {}

class MealsLoaded extends MealsState {
  @override
  List<Meal> get props => meals;
  final List<Meal> meals;

  MealsLoaded(this.meals) : assert(meals != null);
}
