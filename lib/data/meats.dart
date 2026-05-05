import 'package:hamburguesa_facil/model/ingredients.dart';
import 'package:hamburguesa_facil/model/meat.dart';

final List<Meat> meats = [
  Meat(
    name: 'Hamburguesa de res clásica',
    estimatedTime: 30.0,
    image: 'assets/meats/res.jpeg',
    isGlutenFree: true,
    ingredients: [
      Ingredient(name: 'Carne de res molida', quantity: 500.0, measure: 'g'),
      Ingredient(name: 'Sal', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Pimienta negra', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Mezcla la carne de res molida con la sal y la pimienta.',
      'Forma las hamburguesas con la mezcla.',
      'Cocina las hamburguesas en una sartén caliente durante unos 4 minutos por cada lado.',
    ],
  ),
  Meat(
    name: 'Hamburguesa de pollo',
    estimatedTime: 40.0,
    image: 'assets/meats/pollo.jpeg',
    isGlutenFree: true,
    ingredients: [
      Ingredient(
          name: 'Pechuga de pollo molida', quantity: 500.0, measure: 'g'),
      Ingredient(name: 'Sal', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Pimienta negra', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Mezcla la pechuga de pollo molida con la sal y la pimienta.',
      'Forma las hamburguesas con la mezcla.',
      'Cocina las hamburguesas en una sartén caliente durante unos 5 minutos por cada lado.',
    ],
  ),
  Meat(
    name: 'Hamburguesa de cordero',
    estimatedTime: 30.0,
    image: 'assets/meats/cordero.jpeg',
    isGlutenFree: true,
    ingredients: [
      Ingredient(
          name: 'Carne de cordero molida', quantity: 500.0, measure: 'g'),
      Ingredient(name: 'Sal', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Pimienta negra', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Mezcla la carne de cordero molida con la sal y la pimienta.',
      'Forma las hamburguesas con la mezcla.',
      'Cocina las hamburguesas en una sartén caliente durante unos 4 minutos por cada lado.',
    ],
  ),
  Meat(
    name: 'Hamburguesa de salmón',
    estimatedTime: 30.0,
    image: 'assets/meats/salmon.jpeg',
    isGlutenFree: true,
    ingredients: [
      Ingredient(name: 'Salmón fresco picado', quantity: 500.0, measure: 'g'),
      Ingredient(name: 'Eneldo fresco', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Sal', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Pimienta negra', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Mezcla el salmón picado con el eneldo, la sal y la pimienta.',
      'Forma las hamburguesas con la mezcla.',
      'Cocina las hamburguesas en una sartén caliente durante unos 4 minutos por cada lado.',
    ],
  ),
  Meat(
    name: 'Hamburguesa de tofu',
    estimatedTime: 40.0,
    image: 'assets/meats/tofu.jpeg',
    isVegetarian: true,
    isGlutenFree: true,
    ingredients: [
      Ingredient(name: 'Tofu firme', quantity: 500.0, measure: 'g'),
      Ingredient(name: 'Salsa de soja', quantity: 50.0, measure: 'ml'),
      Ingredient(name: 'Aceite de sésamo', quantity: 20.0, measure: 'ml'),
      Ingredient(name: 'Ajo picado', quantity: 10.0, measure: 'g'),
    ],
    steps: [
      'Desmorona el tofu y mézclalo con la salsa de soja, el aceite de sésamo y el ajo picado.',
      'Forma las hamburguesas con la mezcla.',
      'Cocina las hamburguesas en una sartén caliente durante unos 5 minutos por cada lado.',
    ],
  ),
  Meat(
    name: 'Hamburguesa de lentejas',
    estimatedTime: 60.0,
    image: 'assets/meats/lentejas.jpeg',
    isVegetarian: true,
    ingredients: [
      Ingredient(name: 'Lentejas cocidas', quantity: 500.0, measure: 'g'),
      Ingredient(name: 'Cebolla picada', quantity: 100.0, measure: 'g'),
      Ingredient(name: 'Ajo picado', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Comino', quantity: 5.0, measure: 'g'),
      Ingredient(name: 'Sal', quantity: 10.0, measure: 'g'),
    ],
    steps: [
      'Mezcla las lentejas cocidas con la cebolla picada, el ajo, el comino y la sal.',
      'Forma las hamburguesas con la mezcla.',
      'Cocina las hamburguesas en una sartén caliente durante unos 5 minutos por cada lado.',
    ],
  ),
  Meat(
    name: 'Hamburguesa de res con chipotle',
    estimatedTime: 30.0,
    image: 'assets/meats/chipotle.jpeg',
    isSpicy: true,
    ingredients: [
      Ingredient(name: 'Carne de res molida', quantity: 500.0, measure: 'g'),
      Ingredient(name: 'Chipotle en adobo', quantity: 50.0, measure: 'g'),
      Ingredient(name: 'Sal', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Pimienta negra', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Mezcla la carne de res molida con el chipotle, la sal y la pimienta.',
      'Forma las hamburguesas con la mezcla.',
      'Cocina las hamburguesas en una sartén caliente durante unos 4 minutos por cada lado.',
    ],
  ),
  Meat(
    name: 'Hamburguesa de res con curry',
    estimatedTime: 30.0,
    image: 'assets/meats/curry.jpeg',
    isSpicy: true,
    ingredients: [
      Ingredient(name: 'Carne de res molida', quantity: 500.0, measure: 'g'),
      Ingredient(name: 'Curry en polvo', quantity: 20.0, measure: 'g'),
      Ingredient(name: 'Sal', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Pimienta negra', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Mezcla la carne de res molida con el curry, la sal y la pimienta.',
      'Forma las hamburguesas con la mezcla.',
      'Cocina las hamburguesas en una sartén caliente durante unos 4 minutos por cada lado.',
    ],
  ),
  Meat(
    name: 'Hamburguesa de res con hierbas provenzales',
    estimatedTime: 30.0,
    image: 'assets/meats/hierbas-provenzales.jpeg',
    ingredients: [
      Ingredient(name: 'Carne de res molida', quantity: 500.0, measure: 'g'),
      Ingredient(name: 'Hierbas provenzales', quantity: 20.0, measure: 'g'),
      Ingredient(name: 'Sal', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Pimienta negra', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Mezcla la carne de res molida con las hierbas provenzales, la sal y la pimienta.',
      'Forma las hamburguesas con la mezcla.',
      'Cocina las hamburguesas en una sartén caliente durante unos 4 minutos por cada lado.',
    ],
  ),
  Meat(
    name: 'Hamburguesa de res rellena de queso cheddar',
    estimatedTime: 40.0,
    image: 'assets/meats/rellena-cheddar.jpeg',
    ingredients: [
      Ingredient(name: 'Carne de res molida', quantity: 500.0, measure: 'g'),
      Ingredient(name: 'Queso cheddar', quantity: 100.0, measure: 'g'),
      Ingredient(name: 'Sal', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Pimienta negra', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Divide la carne de res molida en porciones.',
      'Coloca un trozo de queso cheddar en el centro de cada porción de carne.',
      'Forma las hamburguesas alrededor del queso.',
      'Cocina las hamburguesas en una sartén caliente durante unos 4 minutos por cada lado.',
    ],
  ),
  Meat(
    name: 'Hamburguesa de res rellena de champiñones',
    estimatedTime: 45.0,
    image: 'assets/meats/champiñones.jpeg',
    ingredients: [
      Ingredient(name: 'Carne de res molida', quantity: 500.0, measure: 'g'),
      Ingredient(name: 'Champiñones picados', quantity: 100.0, measure: 'g'),
      Ingredient(name: 'Sal', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Pimienta negra', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Divide la carne de res molida en porciones.',
      'Coloca los champiñones picados en el centro de cada porción de carne.',
      'Forma las hamburguesas alrededor de los champiñones.',
      'Cocina las hamburguesas en una sartén caliente durante unos 4 minutos por cada lado.',
    ],
  ),
  Meat(
    name: 'Hamburguesa de res rellena de tocino y cebolla caramelizada',
    estimatedTime: 60.0,
    image: 'assets/meats/tocino-cebolla-caramelo.jpeg',
    isSpicy: false,
    ingredients: [
      Ingredient(name: 'Carne de res molida', quantity: 500.0, measure: 'g'),
      Ingredient(name: 'Tocino picado', quantity: 50.0, measure: 'g'),
      Ingredient(name: 'Cebolla caramelizada', quantity: 50.0, measure: 'g'),
      Ingredient(name: 'Sal', quantity: 10.0, measure: 'g'),
      Ingredient(name: 'Pimienta negra', quantity: 5.0, measure: 'g'),
    ],
    steps: [
      'Divide la carne de res molida en porciones.',
      'Coloca el tocino picado y la cebolla caramelizada en el centro de cada porción de carne.',
      'Forma las hamburguesas alrededor del relleno.',
      'Cocina las hamburguesas en una sartén caliente durante unos 4 minutos por cada lado.',
    ],
  ),
];
