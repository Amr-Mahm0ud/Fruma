import 'package:flutter/material.dart';
import 'package:fruma/buy_fruit.dart';
import 'package:fruma/provider_controller.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  late double totalPrice;

  @override
  Widget build(BuildContext context) {
    totalPrice = 0;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your Cart',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 70,
        ),
        body: Provider.of<MyProvider>(context).orders.isEmpty
            ? const Center(
                child: Text(
                  'Nothing to show',
                  style: TextStyle(fontSize: 25),
                ),
              )
            : Stack(
                children: [
                  ListView(
                    children: Provider.of<MyProvider>(context)
                        .orders
                        .entries
                        .map((item) {
                      totalPrice += (item.value.price * item.value.quantity);
                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    item.value.imgSrc,
                                    scale: 7,
                                  ),
                                  Text(
                                    item.value.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  const SizedBox(width: 70),
                                  Text(
                                    '${item.value.quantity} KG',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    '\$${(item.value.price * item.value.quantity).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BuyFruit(item.value)));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Provider.of<MyProvider>(context,
                                              listen: false)
                                          .removeOrder(item.value);
                                      final sBar = buildSnackBar(item);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(sBar);
                                    },
                                    icon: const Icon(
                                      IconData(0xe16a,
                                          fontFamily: 'MaterialIcons'),
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Align(
                    alignment: const Alignment(0,1),
                    child: buildContainer(),
                  )
                ],
              ),
        bottomNavigationBar: buildBottomNavigationBar(context));
  }

  SnackBar buildSnackBar(MapEntry<String, Fruit> item) {
    return SnackBar(
      content: const Text('Order was deleted'),
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10.0),
      action: SnackBarAction(
        label: 'Undo!',
        onPressed: () {
          Provider.of<MyProvider>(context, listen: false).addOrder(item.value);
        },
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.black54,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      currentIndex: Provider.of<MyProvider>(context).current,
      onTap: (index) {
        Provider.of<MyProvider>(context, listen: false)
            .onItemTapped(index, context);
      },
      iconSize: 30,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none_outlined),
          label: 'Level',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Achievements',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined),
          label: 'Settings',
        ),
      ],
    );
  }

  Container buildContainer() {
    return Container(
      height: 160,
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Price',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)),
              Text(totalPrice.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 100),
              child: Text(
                'Confirm',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
