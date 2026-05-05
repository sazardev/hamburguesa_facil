import 'package:hamburguesa_facil/model/recipe.dart';

class Dressing extends Recipe {
  Dressing({
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
