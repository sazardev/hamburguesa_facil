import 'package:hamburguesa_facil/model/recipe.dart';

class Bread extends Recipe {
  Bread({
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
