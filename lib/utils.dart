import 'dart:math';

class Utils {
  static const List<String> SUGGESTIONS = [
    "Beef",
    "Pork",
    "Chicken",
  ];

  String getRandomWordFromList() {
    Random rnd = new Random();
    int min = 0;
    int max = SUGGESTIONS.length;
    return SUGGESTIONS[min + rnd.nextInt(max - min)];
  }
}
