import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:food_bloc/models/meals.dart';
import 'package:food_bloc/repository/meals_repo.dart';

part 'meal_details_event.dart';
part 'meal_details_state.dart';

class MealDetailsBloc extends Bloc<MealDetailsEvent, MealDetailsState> {
  final MealsRepo mealsRepo;
  MealDetailsBloc({@required this.mealsRepo}) : super(MealDetailsInitial());

  @override
  Future<void> close() {
    mealsRepo.mealDetailsController.close();
    return super.close();
  }

  @override
  Stream<MealDetailsState> mapEventToState(
    MealDetailsEvent event,
  ) async* {
    if (event is GetMealDetails) {
      yield MealDetailsLoading();
      try {
        mealsRepo.getMealDetails(event.id).listen((mealDetails) {
          if (mealDetails != null) {
            add(SetMealDetails(mealDetails));
          }
        });
      } catch (e) {
        yield MealDetailsError();
      }
    } else if (event is SetMealDetails) {
      yield MealDetailsLoaded(event.mealDetails);
    }
  }
}
