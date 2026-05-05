import 'package:hamburguesa_facil/model/recipe.dart';

class Meat extends Recipe {
  Meat({
    required super.name,
    required super.estimatedTime,
    required super.ingredients,
    required super.steps,
    super.image,
    super.isVegetarian,
    super.isGlutenFree,
    super.isSpicy,
  });
}
