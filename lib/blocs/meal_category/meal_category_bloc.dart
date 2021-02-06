import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:food_bloc/models/category.dart';

import '../../repository/meals_repo.dart';

part 'meal_category_event.dart';
part 'meal_category_state.dart';

class MealCategoryBloc extends Bloc<MealCategoryEvent, MealCategoryState> {
  final MealsRepo mealsRepo;
  MealCategoryBloc({@required this.mealsRepo}) : super(MealCategoryInitial()) {
    add(FetchCategories());
  }

  @override
  Stream<MealCategoryState> mapEventToState(
    MealCategoryEvent event,
  ) async* {
    if (event is FetchCategories) {
      yield MealCategoryLoading();
      try {
        mealsRepo.listenToCategories().listen((event) {
          add(CategoriesLoaded(event));
        });
      } catch (e) {
        yield MealCategoryError();
      }
    } else if (event is CategoriesLoaded) {
      if (state is MealCategoryLoaded) {
        yield MealCategoryLoading();
      }
      yield MealCategoryLoaded(event.categories);
    }
  }
}
