import 'package:flutter/material.dart';
import 'package:food_bloc/models/meals.dart';

class MealsGrid extends StatelessWidget {
  final List<Meal> meals;

  const MealsGrid({Key key, @required this.meals}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                color: Colors.black.withOpacity(.7),
                child: Text(
                  meals[index].strMeal,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
        );
      },
    );
  }
}
