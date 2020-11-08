import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:food_bloc/models/meal_details.dart';
import 'package:food_bloc/repository/meals_repo.dart';

part 'meal_details_event.dart';
part 'meal_details_state.dart';

class MealDetailsBloc extends Bloc<MealDetailsEvent, MealDetailsState> {
  final MealsRepo mealsRepo;
  MealDetailsBloc({@required this.mealsRepo}) : super(MealDetailsInitial());

  @override
  Stream<MealDetailsState> mapEventToState(
    MealDetailsEvent event,
  ) async* {
    if (event is GetMealDetails) {
      yield MealDetailsLoading();
      try {
        final MealDetails mealDetails =
            await mealsRepo.getMealDetails(event.id);
        if (mealDetails != null) {
          yield MealDetailsLoaded(mealDetails);
        } else {
          yield MealDetailsError();
        }
      } catch (e) {
        yield MealDetailsError();
      }
    }
  }
}
