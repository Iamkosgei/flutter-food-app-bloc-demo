import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_bloc/blocs/meal_details/meal_details_bloc.dart';
import 'package:food_bloc/models/meals.dart';

class MealsDetailsPage extends StatefulWidget {
  final Meal meal;

  const MealsDetailsPage({Key key, @required this.meal}) : super(key: key);

  @override
  _MealsDetailsPageState createState() => _MealsDetailsPageState();
}

class _MealsDetailsPageState extends State<MealsDetailsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MealDetailsBloc>(context)
        .add(GetMealDetails(widget.meal.idMeal.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
            iconTheme: IconThemeData(
              color: Colors.green,
            ),
            expandedHeight: 400,
            floating: false,
            pinned: true,
            flexibleSpace: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: CachedNetworkImage(
                  imageUrl: widget.meal.strMealThumb,
                  fit: BoxFit.cover,
                )),
              ],
            )),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Text(widget.meal.strMeal,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
            ]),
          ),
        ),
        BlocBuilder<MealDetailsBloc, MealDetailsState>(
            builder: (context, MealDetailsState state) {
          if (state is MealDetailsLoading) {
            return SliverList(
                delegate: SliverChildListDelegate([
              Center(
                child: CircularProgressIndicator(),
              ),
            ]));
          } else if (state is MealDetailsLoaded) {
            return SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Text(
                        "Instructions".toUpperCase(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      MealDetailsTag(
                        tags: state.mealDetails.strTags?.split(","),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(state.mealDetails.strInstructions?.toLowerCase() ??
                          "")
                    ],
                  ),
                )
              ])),
            );
          }
          return SliverList(
            delegate: SliverChildListDelegate([
              Center(
                child: Text("error"),
              )
            ]),
          );
        })
      ],
    ));
  }
}

class MealDetailsTag extends StatelessWidget {
  final List<String> tags;

  const MealDetailsTag({Key key, this.tags}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: tags == null ? 0 : 30,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, index) {
            return SizedBox(
              width: 10,
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: tags?.length ?? 0,
          itemBuilder: (BuildContext context, index) {
            return FlatButton(
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              onPressed: () {},
              child: Text(
                tags[index],
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }),
    );
  }
}
