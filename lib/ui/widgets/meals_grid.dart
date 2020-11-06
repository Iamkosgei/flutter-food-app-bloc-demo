import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_bloc/blocs/meals/meals_bloc.dart';
import 'package:food_bloc/models/meals.dart';

class MealsGrid extends StatelessWidget {
  final List<Meal> meals;

  const MealsGrid({Key key, @required this.meals}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<MealsBloc>(context).add(FetchMeals());
        return Future.value(true);
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: meals.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            height: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                meals[index].strMealThumb,
              ),
              fit: BoxFit.cover,
            )),
            child: Align(
                alignment:
                    index.isEven ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  width: size.width / 3,
                  color: Colors.green,
                  child: Text(
                    meals[index].strMeal,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
