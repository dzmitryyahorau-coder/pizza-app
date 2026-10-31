import 'package:pizza_app/features/product_details/data/product_size.dart';
import 'package:pizza_app/features/product_details/data/dough.dart';
import 'package:pizza_app/features/product_details/data/product_details.dart';
import 'package:pizza_app/features/product_details/data/topping.dart';
import 'package:pizza_app/features/product_details/data/ingredient.dart';

final productDetails = [
  ProductDetails(
    id: 'p4', // как у «Маргариты» в моках меню, поменяйте, если у вас другой
    name: 'Маргарита',
    description:
        'Увеличенная порция моцареллы, томаты, итальянские травы, '
        'фирменный томатный соус',
    imageAsset: 'assets/images/products/margherita.png',
    defaultSizeId: 's30',
    sizes: const [
      ProductSize(id: 's25', cm: 25, price: 369),
      ProductSize(id: 's30', cm: 30, price: 469),
      ProductSize(id: 's35', cm: 35, price: 569),
    ],
    dough: const Dough(
      id: 'traditional',
      name: 'Традиционное',
      imageAsset: 'assets/images/dough/traditional.png',
    ),
    toppings: const [
      Topping(
        id: 'pepperoni',
        name: 'Пепперони',
        weightGrams: 15,
        price: 89,
        imageAsset: 'assets/images/toppings/pepperoni.png',
      ),
      Topping(
        id: 'pineapple',
        name: 'Ананас',
        weightGrams: 15,
        price: 39,
        imageAsset: 'assets/images/toppings/pineapple.png',
      ),
      Topping(
        id: 'mushrooms',
        name: 'Шампиньоны',
        weightGrams: 15,
        price: 49,
        imageAsset: 'assets/images/toppings/mushrooms.png',
      ),
      Topping(
        id: 'jalapenos',
        name: 'Халапеньо',
        weightGrams: 15,
        price: 39,
        imageAsset: 'assets/images/toppings/jalapenos.png',
      ),
      Topping(
        id: 'cheddar_parmesan',
        name: 'Пармезан и чеддер',
        weightGrams: 15,
        price: 69,
        imageAsset: 'assets/images/toppings/cheddar_parmesan.png',
      ),
      Topping(
        id: 'bacon',
        name: 'Бекон',
        weightGrams: 15,
        price: 89,
        imageAsset: 'assets/images/toppings/bacon.png',
      ),
    ],
    ingredients: const [
      Ingredient(id: 'tomatoes', name: 'Томаты'),
      Ingredient(id: 'mozzarella', name: 'Моцарелла'),
      Ingredient(id: 'tomato_sauce', name: 'Фирменный томатный соус'),
      Ingredient(id: 'sweet_pepper', name: 'Сладкий перец'),
      Ingredient(id: 'red_onion', name: 'Красный лук'),
    ],
  ),
];

const ingredients = [
  Topping(
    id: 'pepperoni',
    name: 'Пепперони',
    weightGrams: 15,
    price: 89,
    imageAsset: 'assets/images/pepperoni.png',
  ),
  Topping(
    id: 'pineapple',
    name: 'Ананас',
    weightGrams: 15,
    price: 39,
    imageAsset: 'assets/images/pineapple.png',
  ),
  Topping(
    id: 'mushrooms',
    name: 'Шампиньоны',
    weightGrams: 15,
    price: 49,
    imageAsset: 'assets/images/champs.png',
  ),
  Topping(
    id: 'jalapenos',
    name: 'Халапеньо',
    weightGrams: 15,
    price: 39,
    imageAsset: 'assets/images/jalapenos.png',
  ),
  Topping(
    id: 'cheddar_parmesan',
    name: 'Пармезан и чеддер',
    weightGrams: 15,
    price: 69,
    imageAsset: 'assets/images/cheese.png',
  ),
  Topping(
    id: 'bacon',
    name: 'Бекон',
    weightGrams: 15,
    price: 89,
    imageAsset: 'assets/images/bacon.png',
  ),
];

const doughs = [
  Dough(
    id: 'traditional',
    name: 'Традиционное',
    imageAsset: 'assets/images/pizza-traditional.png',
  ),
  Dough(id: 'thin', name: 'Тонкое', imageAsset: 'assets/images/pizza-thin.png'),
];
