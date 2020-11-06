import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_bloc/blocs/meals/meals_bloc.dart';

import '../../utils.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    } else {
      _submitSearch(query, context);
      return Container();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> _tempList = [...Utils.SUGGESTIONS];
    _tempList.addAll(["Chocolate", "Salad", "Salmon", "Tea", "Bread"]);

    List<String> _newList = _tempList;

    if (query.trim().isNotEmpty) {
      _newList = _tempList
          .where(
              (element) => element.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    return ListView.separated(
      separatorBuilder: (BuildContext context, index) {
        return Divider();
      },
      itemCount: _newList.length,
      itemBuilder: (BuildContext context, index) {
        return ListTile(
          title: Text(_newList[index]),
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _submitSearch(_newList[index], context);
            });
          },
        );
      },
    );
  }

  _submitSearch(String query, BuildContext context) {
    BlocProvider.of<MealsBloc>(context).add(SearchMeal(query));
    Navigator.pop(context);
  }
}
