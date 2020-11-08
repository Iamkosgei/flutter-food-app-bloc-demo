part of 'meal_details_bloc.dart';

abstract class MealDetailsState extends Equatable {
  const MealDetailsState();

  @override
  List<Object> get props => [];
}

class MealDetailsInitial extends MealDetailsState {}

class MealDetailsLoading extends MealDetailsState {}

class MealDetailsLoaded extends MealDetailsState {
  final MealDetails mealDetails;
  @override
  List<MealDetails> get props => [mealDetails];

  MealDetailsLoaded(this.mealDetails) : assert(mealDetails != null);
}

class MealDetailsError extends MealDetailsState {}
