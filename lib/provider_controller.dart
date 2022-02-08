import 'package:flutter/material.dart';
import 'package:fruma/cart.dart';

import 'main_page.dart';

class MyProvider with ChangeNotifier {
  Map<String, String> userData = {'name': ' ', 'email': ' ', 'password': ' '};
  int current = 0;
  Map<String, Fruit> orders = {};

  final List<Fruit> fruits = [
    Fruit(
        imgSrc: 'assets/images/orange.png',
        name: 'Orange',
        price: 2.50,
        quantity: 1),
    Fruit(
        imgSrc: 'assets/images/sb.png',
        name: 'Strawberry',
        price: 2.99,
        quantity: 1),
    Fruit(
        imgSrc: 'assets/images/mango.png',
        name: 'mango',
        price: 3.45,
        quantity: 1),
    Fruit(
        imgSrc: 'assets/images/orange.png',
        name: 'Orange',
        price: 2.50,
        quantity: 1),
    Fruit(
        imgSrc: 'assets/images/sb.png',
        name: 'Strawberry',
        price: 2.99,
        quantity: 1),
    Fruit(
        imgSrc: 'assets/images/mango.png',
        name: 'mango',
        price: 3.45,
        quantity: 1),
    Fruit(
        imgSrc: 'assets/images/orange.png',
        name: 'Orange',
        price: 2.50,
        quantity: 1),
    Fruit(
        imgSrc: 'assets/images/sb.png',
        name: 'Strawberry',
        price: 2.99,
        quantity: 1),
    Fruit(
        imgSrc: 'assets/images/mango.png',
        name: 'mango',
        price: 3.45,
        quantity: 1),
    Fruit(
        imgSrc: 'assets/images/orange.png',
        name: 'Orange',
        price: 2.50,
        quantity: 1),
    Fruit(
        imgSrc: 'assets/images/sb.png',
        name: 'Strawberry',
        price: 2.99,
        quantity: 1),
    Fruit(
        imgSrc: 'assets/images/mango.png',
        name: 'mango',
        price: 3.45,
        quantity: 1),
  ];

  int i = 1;

  void addUserEmail(String valE) {
    userData['email'] = valE;
  }

  void addUserPassword(String valP) {
    userData['password'] = valP;
  }

  void addOrder(Fruit order) {
    orders['Order #$i'] = order;
    i++;
    notifyListeners();
  }

  void removeOrder(Fruit item) {
    orders.removeWhere((key, value) => value == item);
    notifyListeners();
  }

  void onItemTapped(int index, BuildContext context) {
    if (index != 2) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const MainPage()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const Cart()));
    }
    current = index;
    notifyListeners();
  }
}

class Fruit {
  final String imgSrc;
  final String name;
  final double price;
  int quantity = 1;

  Fruit({
    required this.imgSrc,
    required this.name,
    required this.price,
    required this.quantity,
  });

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) quantity--;
  }
}
