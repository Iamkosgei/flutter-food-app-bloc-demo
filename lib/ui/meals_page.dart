import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_bloc/blocs/meals/meals_bloc.dart';

import 'meals_grid.dart';

class MealsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.orange,
        elevation: 0.0,
        title: Text(
          "Food Bloc",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<MealsBloc, MealsState>(
        listener: (context, MealsState state) {
          if (state is MealsError) {
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text('Error'),
            ));
          }
        },
        child: BlocBuilder<MealsBloc, MealsState>(
            // cubit: _mealsBloc,
            builder: (context, MealsState state) {
          if (state is MealsInitial) {
            return Container();
          }
          if (state is MealsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MealsLoaded) {
            return MealsGrid(
              meals: state.props,
            );
          }
          return Container(
            child: Center(
              child: Text("Error"),
            ),
          );
        }),
      ),
    );
  }
}
