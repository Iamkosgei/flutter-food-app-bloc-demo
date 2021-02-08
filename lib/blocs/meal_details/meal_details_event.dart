part of 'meal_details_bloc.dart';

abstract class MealDetailsEvent extends Equatable {
  const MealDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetMealDetails extends MealDetailsEvent {
  final String id;
  const GetMealDetails(this.id);
}

class SetMealDetails extends MealDetailsEvent {
  final Meal mealDetails;
  const SetMealDetails(this.mealDetails);
}
