import 'package:flutter/material.dart';
import 'package:fruma/provider_controller.dart';
import 'package:provider/provider.dart';

class BuyFruit extends StatefulWidget {
  final Fruit item;

  const BuyFruit(this.item, {Key? key}) : super(key: key);

  @override
  State<BuyFruit> createState() => _BuyFruitState();
}

class _BuyFruitState extends State<BuyFruit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item.name,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.search,
              color: Colors.grey,
              size: 35,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35.0, bottom: 20),
              child: Image.asset(
                widget.item.imgSrc,
                scale: 1.7,
              ),
            ),
            Text(
              widget.item.name,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Container(
              width: 170,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey[200]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.item.decrementQuantity();
                        });
                      },
                      icon: const Icon(Icons.remove)),
                  Text(
                    '${widget.item.quantity} KG',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.item.incrementQuantity();
                        });
                      },
                      icon: const Icon(Icons.add)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${(widget.item.price * widget.item.quantity).toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            const SizedBox(height: 30),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<MyProvider>(context, listen: false)
                      .addOrder(widget.item);
                  final sBar = buildSnackBar(widget.item);
                  ScaffoldMessenger.of(context).showSnackBar(sBar);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add_shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Add To Cart',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shadowColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
              ),
            )
          ],
        ),
      ),
    );
  }
  SnackBar buildSnackBar(Fruit item) {
    return SnackBar(
      content: const Text('Order was added'),
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10.0),
      action: SnackBarAction(
        label: 'Undo!',
        onPressed: () {
          Provider.of<MyProvider>(context, listen: false).removeOrder(item);
        },
      ),
    );
  }

}
