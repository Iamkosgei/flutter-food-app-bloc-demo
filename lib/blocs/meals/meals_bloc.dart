import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:food_bloc/models/meals.dart';
import 'package:food_bloc/repository/meals_repo.dart';

part 'meals_event.dart';
part 'meals_state.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final MealsRepo mealsRepo;
  MealsBloc({@required this.mealsRepo}) : super(MealsInitial()) {
    add(FetchMeals());
  }

  MealsState get initialState => MealsInitial();

  @override
  Stream<MealsState> mapEventToState(
    MealsEvent event,
  ) async* {
    if (event is FetchMeals) {
      yield MealsLoading();

      try {
        final List<Meal> meals = await mealsRepo.getMeals();
        yield MealsLoaded(meals);
      } catch (_) {
        yield MealsError();
      }
    }
  }
}
