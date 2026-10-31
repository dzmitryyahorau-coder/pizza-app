import 'package:flutter/animation.dart';
import 'package:pizza_app/features/menu/data/category.dart';
import 'package:pizza_app/features/menu/data/product.dart';
import 'package:pizza_app/features/menu/data/story.dart';

const stories = [
  Story(
    label: 'Призы за пикники',
    image: 'assets/images/altyn.jpg',
    badge: 'sparkles',
    bgColor: Color(0XFF5DA8FF),
  ),
  Story(
    label: 'Завтраки в меню',
    image: 'assets/images/cheese-pnks.png',
    badge: 'fire',
    bgColor: Color(0xFFFF6900),
  ),
  Story(label: 'Лучшее начало дня', image: 'assets/images/best-begin-day.png'),
  Story(label: 'Доставка за 10 минут', image: 'assets/images/delivery-10.png'),
  Story(label: 'Ура, лето!', image: 'assets/images/best-begin-day.png'),
  Story(label: 'Ешь и худей', image: 'assets/images/delivery-10.png'),
];

const categories = [
  Category(id: 'pizza', name: 'Пицца'),
  Category(id: 'breakfast', name: 'Завтраки'),
  Category(id: 'combo', name: 'Комбо'),
  Category(id: 'snacks', name: 'Закуски'),
  Category(id: 'drinks', name: 'Напитки'),
  Category(
    id: 'desserts',
    name: 'Десерты',
  ), // намеренно без товаров: проверка пустого состояния
];

const products = [
  // Пицца
  Product(
    id: 'p1',
    categoryId: 'pizza',
    name: 'Додо',
    description:
        'Бекон, митболы, пикантная пепперони, моцарелла, томаты, шампиньоны, '
        'сладкий перец, красный лук, чеснок, фирменный томатный соус',
    price: 669,
    badge: 'Хит',
  ),
  Product(
    id: 'p2',
    categoryId: 'pizza',
    name: 'Сырный цыпленок',
    description:
        'Цыпленок, моцарелла, сыры чеддер и пармезан, сырный соус, томаты, '
        'фирменный соус альфредо, чеснок',
    price: 395,
  ),
  Product(
    id: 'p3',
    categoryId: 'pizza',
    name: 'Пепперони',
    description: 'Пикантная пепперони, моцарелла, фирменный томатный соус',
    price: 449,
    badge: 'Хит',
  ),
  Product(
    id: 'p4',
    categoryId: 'pizza',
    name: 'Маргарита',
    description: 'Моцарелла, томаты, фирменный томатный соус, орегано',
    price: 349,
  ),
  Product(
    id: 'p5',
    categoryId: 'pizza',
    name: 'Четыре сыра',
    description:
        'Моцарелла, чеддер, пармезан, сыр с голубой плесенью, сырный соус',
    price: 499,
  ),
  Product(
    id: 'p6',
    categoryId: 'pizza',
    name: 'Гавайская',
    description: 'Ветчина, ананасы, моцарелла, фирменный томатный соус',
    price: 429,
  ),

  // Завтраки
  Product(
    id: 'b1',
    categoryId: 'breakfast',
    name: 'Бруслетики с клюквой',
    description: 'Сдобные булочки с клюквенной начинкой и сахарной глазурью',
    price: 395,
  ),
  Product(
    id: 'b2',
    categoryId: 'breakfast',
    name: 'Омлет с ветчиной',
    description: 'Яйца, ветчина, моцарелла, томаты, зелёный лук',
    price: 259,
  ),
  Product(
    id: 'b3',
    categoryId: 'breakfast',
    name: 'Сырники',
    description: 'Творожные сырники со сметаной и ягодным соусом',
    price: 229,
  ),

  // Комбо
  Product(
    id: 'c1',
    categoryId: 'combo',
    name: 'Комбо на двоих',
    description: 'Две пиццы 25 см на выбор и два напитка',
    price: 899,
    badge: 'Выгодно',
  ),
  Product(
    id: 'c2',
    categoryId: 'combo',
    name: 'Обед',
    description: 'Пицца 25 см, закуска и напиток',
    price: 599,
  ),

  // Закуски
  Product(
    id: 's1',
    categoryId: 'snacks',
    name: 'Картофель из печи',
    description: 'Запечённый картофель с розмарином и чесночным соусом',
    price: 179,
  ),
  Product(
    id: 's2',
    categoryId: 'snacks',
    name: 'Куриные наггетсы',
    description: 'Хрустящие наггетсы из куриной грудки, 6 шт.',
    price: 249,
  ),
  Product(
    id: 's3',
    categoryId: 'snacks',
    name: 'Сырные палочки',
    description: 'Моцарелла в хрустящей панировке с кисло-сладким соусом',
    price: 219,
  ),

  // Напитки
  Product(
    id: 'd1',
    categoryId: 'drinks',
    name: 'Морс клюквенный',
    description: 'Домашний морс из клюквы, 0,5 л',
    price: 149,
  ),
  Product(
    id: 'd2',
    categoryId: 'drinks',
    name: 'Лимонад',
    description: 'Лимон, мята, содовая, 0,4 л',
    price: 169,
  ),
];
