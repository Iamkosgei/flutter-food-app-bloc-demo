import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_bloc/blocs/meals/meals_bloc.dart';

import '../widgets/meals_empty.dart';
import '../widgets/meals_grid.dart';

class MealsPage extends StatelessWidget {
  final String category;

  const MealsPage({Key key, @required this.category}) : super(key: key);
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
          "$category",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MealsBloc, MealsState>(
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
                        BlocProvider.of<MealsBloc>(context)
                            .add(FetchMeals(category));
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
    );
  }
}
