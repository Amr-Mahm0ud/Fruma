import 'package:flutter/material.dart';
import 'package:fruma/provider_controller.dart';
import 'package:provider/provider.dart';

class YourOrders extends StatefulWidget {
  const YourOrders({Key? key}) : super(key: key);

  @override
  State<YourOrders> createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        titleTextStyle: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      body: Provider.of<MyProvider>(context).orders.isEmpty
          ? const Center(
              child: Text(
                'Nothing to show',
                style: TextStyle(fontSize: 25),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: Provider.of<MyProvider>(context)
                    .orders
                    .entries
                    .map(
                      (item) => Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                            ),
                            constraints: BoxConstraints(
                              minHeight: show == true ? 150 : 50,
                              maxHeight: show == true ? 170 : 56,
                            ),
                            child: ListView(
                              children: [
                                ListTile(
                                  tileColor: Colors.transparent,
                                  title: Text(
                                    item.key,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  trailing:
                                      const Icon(Icons.keyboard_arrow_down),
                                  onTap: () {
                                    setState(() {
                                      show = !show;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.value.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 170),
                                      Text(
                                        '${item.value.quantity} KG',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '\$${item.value.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17.0, vertical: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Status',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 170),
                                      Text(
                                        'Not Delivered',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17.0, vertical: 5),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.attach_money,
                                        color: Colors.amber,
                                      ),
                                      const Text(
                                        'Price',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.amber),
                                      ),
                                      const SizedBox(width: 180),
                                      Text(
                                        (item.value.price * item.value.quantity)
                                            .toStringAsFixed(2),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber,
                                            fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
