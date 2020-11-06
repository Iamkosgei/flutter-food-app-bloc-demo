import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_bloc/blocs/meals/meals_bloc.dart';

import 'widgets/meals_empty.dart';
import 'widgets/meals_grid.dart';
import 'widgets/recipe_search_delagate.dart';

class MealsPage extends StatelessWidget {
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
          "Food",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: BlocListener<MealsBloc, MealsState>(
        listener: (context, MealsState state) {
          //navigation or snackbars
        },
        child: BlocBuilder<MealsBloc, MealsState>(
            // cubit: _mealsBloc,
            builder: (context, MealsState state) {
          if (state is MealsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MealsLoaded) {
            return MealsGrid(
              meals: state.props.reversed.toList(),
            );
          } else if (state is MealsError) {
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
                          BlocProvider.of<MealsBloc>(context).add(FetchMeals());
                        })
                  ],
                ),
              ),
            );
          } else if (state is MealsEmpty) {
            return MealsEmptyWidget();
          }
          return Container();
        }),
      ),
    );
  }
}
