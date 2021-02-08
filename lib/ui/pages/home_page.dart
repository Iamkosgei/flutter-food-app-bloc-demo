import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_bloc/blocs/meal_category/meal_category_bloc.dart';
import 'package:food_bloc/models/category.dart';

import '../../blocs/meals/meals_bloc.dart';
import '../../utils.dart';
import 'meals_page.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.green,
        elevation: 0.0,
        title: Text(
          "Categories",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[],
        leading: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            BlocProvider.of<MealCategoryBloc>(context).add(FetchCategories());
          },
        ),
      ),
      body: BlocListener<MealCategoryBloc, MealCategoryState>(
        listener: (context, MealCategoryState state) {
          //navigation or snackbars
        },
        child: BlocBuilder<MealCategoryBloc, MealCategoryState>(
            builder: (context, MealCategoryState state) {
          if (state is MealCategoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MealCategoryLoaded) {
            return GridView.builder(
                itemCount: state.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  Category category = state.categories[index];
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<MealsBloc>(context)
                          .add(FetchMeals(category.strCategory));

                      Navigator.pushNamed(context, Utils.CATEGORY,
                          arguments: category.strCategory);
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: -7,
                              offset: Offset(0, 10),
                              color: Colors.green.withOpacity(0.2),
                              blurRadius: 25,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        crossAxisAlignment: index.isEven
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          CachedNetworkImage(
                            imageUrl: category.strCategoryThumb,
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(4.0),
                            color: Colors.green,
                            child: Text(
                              category.strCategory,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );

                  // GridTile(
                  //     child: Image.network(category.strCategoryThumb));
                });
          } else if (state is MealCategoryError) {
            return Container(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Error"),
                    SizedBox(
                      height: 50,
                    ),
                    CupertinoButton.filled(
                        child: Text(
                          "Retry",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<MealCategoryBloc>(context)
                              .add(FetchCategories());
                        })
                  ],
                ),
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
