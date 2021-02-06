part of 'meal_details_bloc.dart';

abstract class MealDetailsState extends Equatable {
  const MealDetailsState();

  @override
  List<Object> get props => [];
}

class MealDetailsInitial extends MealDetailsState {}

class MealDetailsLoading extends MealDetailsState {}

class MealDetailsLoaded extends MealDetailsState {
  final Meal mealDetails;
  @override
  List<Meal> get props => [mealDetails];

  MealDetailsLoaded(this.mealDetails) : assert(mealDetails != null);
}

class MealDetailsError extends MealDetailsState {}
