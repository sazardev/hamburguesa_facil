import 'package:hamburguesa_facil/model/ingredients.dart';
import 'package:hamburguesa_facil/model/dressing.dart';

final List<Dressing> dressing = [
  Dressing(
    name: 'Mayonesa de chipotle',
    estimatedTime: 15.0,
    image: 'assets/dressing/salsa-chipotle.jpeg',
    isSpicy: true,
    ingredients: [
      Ingredient(name: 'Mayonesa', quantity: 200.0, measure: 'g'),
      Ingredient(name: 'Chipotle en adobo', quantity: 20.0, measure: 'g'),
    ],
    steps: [
      'Mezcla la mayonesa con el chipotle en adobo hasta obtener una consistencia suave.',
    ],
  ),
  Dressing(
    name: 'Mostaza y miel',
    estimatedTime: 10.0,
    image: 'assets/dressing/salsa-miel.jpeg',
    isVegetarian: true,
    ingredients: [
      Ingredient(name: 'Mostaza', quantity: 100.0, measure: 'g'),
      Ingredient(name: 'Miel', quantity: 50.0, measure: 'g'),
    ],
    steps: [
      'Mezcla la mostaza con la miel hasta obtener una consistencia suave.',
    ],
  ),
  Dressing(
    name: 'Salsa BBQ casera',
    estimatedTime: 30.0,
    image: 'assets/dressing/salsa-bbq.jpeg',
    isVegetarian: true,
    ingredients: [
      Ingredient(name: 'Ketchup', quantity: 200.0, measure: 'ml'),
      Ingredient(name: 'Miel', quantity: 50.0, measure: 'ml'),
      Ingredient(name: 'Vinagre de manzana', quantity: 50.0, measure: 'ml'),
      Ingredient(name: 'Salsa Worcestershire', quantity: 20.0, measure: 'ml'),
    ],
    steps: [
      'Mezcla todos los ingredientes en una cacerola.',
      'Cocina a fuego lento durante 20 minutos, removiendo ocasionalmente.',
    ],
  ),
  Dressing(
    name: 'Mayonesa de ajo (aioli)',
    estimatedTime: 15.0,
    image: 'assets/dressing/salsa-ajo.jpeg',
    isVegetarian: true,
    ingredients: [
      Ingredient(name: 'Mayonesa', quantity: 200.0, measure: 'g'),
      Ingredient(name: 'Ajo', quantity: 2.0, measure: 'dientes'),
    ],
    steps: [
      'Tritura el ajo y mézclalo con la mayonesa hasta obtener una consistencia suave.',
    ],
  ),
  Dressing(
    name: 'Salsa tártara',
    estimatedTime: 20.0,
    image: 'assets/dressing/salsa-tartara.jpeg',
    ingredients: [
      Ingredient(name: 'Mayonesa', quantity: 200.0, measure: 'g'),
      Ingredient(name: 'Pepinillos en vinagre', quantity: 50.0, measure: 'g'),
      Ingredient(name: 'Alcaparras', quantity: 20.0, measure: 'g'),
      Ingredient(name: 'Perejil', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Zumo de limón', quantity: 1.0, measure: 'unidad'),
    ],
    steps: [
      'Pica los pepinillos, las alcaparras y el perejil.',
      'Mezcla la mayonesa con los ingredientes picados y el zumo de limón hasta obtener una consistencia suave.',
    ],
  ),
];
