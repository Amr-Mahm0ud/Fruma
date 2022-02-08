import 'package:flutter/material.dart';
import 'package:fruma/buy_fruit.dart';
import 'package:fruma/provider_controller.dart';
import 'package:provider/provider.dart';

class MoreFruits extends StatefulWidget {
  final String title;

  const MoreFruits(this.title, {Key? key}) : super(key: key);

  @override
  State<MoreFruits> createState() => _MoreFruitsState();
}

class _MoreFruitsState extends State<MoreFruits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(widget.title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 4 / 5,
          ),
          children: Provider.of<MyProvider>(context).fruits.map((item) {
            return InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => BuyFruit(item)));
              },
              child: Container(
                width: 175,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12, blurRadius: 3, spreadRadius: 3)
                    ]),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      item.imgSrc,
                      scale: 5,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      item.name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.price.toString(),
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
