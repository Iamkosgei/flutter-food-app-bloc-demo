import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:food_bloc/models/meals.dart';
import 'package:food_bloc/ui/pages/meals_details_page.dart';

class MealsGrid extends StatelessWidget {
  final List<Meal> meals;

  const MealsGrid({Key key, @required this.meals}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () {
        // BlocProvider.of<MealsBloc>(context).add(FetchMeals());
        return Future.value(true);
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: meals.length,
        itemBuilder: (BuildContext context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MealsDetailsPage(
                            meal: meals[index],
                          )));
            },
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: CachedNetworkImageProvider(
                  meals[index].strMealThumb,
                ),
                fit: BoxFit.cover,
              )),
              child: Align(
                  alignment: index.isEven
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    width: size.width / 3,
                    color: Colors.green,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        meals[index].strMeal,
                        textAlign:
                            index.isEven ? TextAlign.end : TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
