import 'package:hamburguesa_facil/model/ingredients.dart';
import 'package:hamburguesa_facil/model/topping.dart';

final List<Topping> toppings = [
  Topping(
    name: 'Tocino crujiente',
    estimatedTime: 10.0,
    image: 'assets/toppings/tocino-crujiente.jpeg',
    ingredients: [
      Ingredient(name: 'Tocino', quantity: 200.0, measure: 'g'),
    ],
    steps: [
      'Cocina el tocino en una sartén caliente hasta que esté crujiente.',
      'Escurre el exceso de grasa en papel de cocina.',
    ],
  ),
  Topping(
    name: 'Queso cheddar derretido',
    estimatedTime: 5.0,
    image: 'assets/toppings/queso-cheddar.jpeg',
    isVegetarian: true,
    ingredients: [
      Ingredient(name: 'Queso cheddar', quantity: 100.0, measure: 'g'),
    ],
    steps: [
      'Coloca el queso cheddar sobre la hamburguesa caliente para que se derrita.',
    ],
  ),
  Topping(
    name: 'Aros de cebolla',
    estimatedTime: 20.0,
    image: 'assets/toppings/ceblla-rodajas.jpeg',
    isVegetarian: true,
    ingredients: [
      Ingredient(name: 'Cebolla', quantity: 1.0, measure: 'unidad'),
      Ingredient(name: 'Harina', quantity: 100.0, measure: 'g'),
      Ingredient(name: 'Huevo', quantity: 1.0, measure: 'unidad'),
      Ingredient(name: 'Pan rallado', quantity: 100.0, measure: 'g'),
    ],
    steps: [
      'Corta la cebolla en aros y pásalos por harina, huevo y pan rallado.',
      'Fríe los aros de cebolla en aceite caliente hasta que estén dorados.',
    ],
  ),
  Topping(
    name: 'Guacamole',
    estimatedTime: 15.0,
    image: 'assets/toppings/guacamole.jpeg',
    isVegetarian: true,
    isGlutenFree: true,
    ingredients: [
      Ingredient(name: 'Aguacate', quantity: 1.0, measure: 'unidad'),
      Ingredient(name: 'Jugo de limón', quantity: 1.0, measure: 'unidad'),
      Ingredient(name: 'Cilantro', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Sal', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Tritura el aguacate y mézclalo con el jugo de limón, el cilantro y la sal.',
    ],
  ),
  Topping(
    name: 'Champiñones salteados',
    estimatedTime: 15.0,
    image: 'assets/toppings/champiñones-salteados.jpeg',
    isVegetarian: true,
    isGlutenFree: true,
    ingredients: [
      Ingredient(name: 'Champiñones', quantity: 200.0, measure: 'g'),
      Ingredient(name: 'Aceite de oliva', quantity: 20.0, measure: 'ml'),
      Ingredient(name: 'Sal', quantity: 5.0, measure: 'g'),
      Ingredient(name: 'Pimienta negra', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Saltea los champiñones en aceite de oliva con sal y pimienta.',
    ],
  ),
  Topping(
    name: 'Cebolla caramelizada',
    estimatedTime: 40.0,
    image: 'assets/toppings/cebolla-caramelizado.jpeg',
    isVegetarian: true,
    isGlutenFree: true,
    ingredients: [
      Ingredient(name: 'Cebolla', quantity: 1.0, measure: 'unidad'),
      Ingredient(name: 'Azúcar moreno', quantity: 20.0, measure: 'g'),
      Ingredient(name: 'Aceite de oliva', quantity: 20.0, measure: 'ml'),
    ],
    steps: [
      'Corta la cebolla en rodajas finas.',
      'Saltea la cebolla en aceite de oliva a fuego medio.',
      'Añade el azúcar moreno y cocina a fuego lento hasta que la cebolla esté caramelizada.',
    ],
  ),
  Topping(
    name: 'Pimientos asados',
    estimatedTime: 60.0,
    image: 'assets/toppings/pimientos-asados.jpeg',
    isVegetarian: true,
    isGlutenFree: true,
    ingredients: [
      Ingredient(name: 'Pimientos rojos', quantity: 2.0, measure: 'unidades'),
      Ingredient(name: 'Aceite de oliva', quantity: 20.0, measure: 'ml'),
      Ingredient(name: 'Sal', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Asa los pimientos en el horno a 200°C durante 30 minutos.',
      'Pela los pimientos y córtalos en tiras.',
      'Saltea los pimientos en aceite de oliva con un poco de sal.',
    ],
  ),
  Topping(
    name: 'Huevo frito',
    estimatedTime: 10.0,
    image: 'assets/toppings/huevo-frito.jpeg',
    isVegetarian: true,
    isGlutenFree: true,
    ingredients: [
      Ingredient(name: 'Huevo', quantity: 1.0, measure: 'unidad'),
      Ingredient(name: 'Aceite de oliva', quantity: 20.0, measure: 'ml'),
    ],
    steps: [
      'Calienta el aceite de oliva en una sartén.',
      'Fríe el huevo hasta que la clara esté completamente cocida y la yema aún esté líquida.',
    ],
  ),
  Topping(
    name: 'Aguacate en rodajas',
    estimatedTime: 5.0,
    image: 'assets/toppings/aguacate.jpeg',
    isVegetarian: true,
    isGlutenFree: true,
    ingredients: [
      Ingredient(name: 'Aguacate', quantity: 1.0, measure: 'unidad'),
      Ingredient(name: 'Limón', quantity: 1.0, measure: 'unidad'),
      Ingredient(name: 'Sal', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Corta el aguacate en rodajas finas.',
      'Rocía las rodajas de aguacate con jugo de limón y espolvorea con sal.',
    ],
  ),
];
