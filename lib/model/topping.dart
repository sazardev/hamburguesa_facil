import 'package:hamburguesa_facil/model/recipe.dart';

class Topping extends Recipe {
  Topping({
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
