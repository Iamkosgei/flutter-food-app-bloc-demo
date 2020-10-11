part of 'meals_bloc.dart';

abstract class MealsEvent extends Equatable {
  const MealsEvent();

  @override
  List<Object> get props => [];
}

class FetchMeals extends MealsEvent {
  const FetchMeals();
}
