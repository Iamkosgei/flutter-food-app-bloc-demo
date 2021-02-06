import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealsEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Couldn't find a meal, try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CupertinoButton.filled(
                child: Text(
                  "Retry",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}
