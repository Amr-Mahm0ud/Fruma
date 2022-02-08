import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool search = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Fruma',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 3, blurRadius: 3)
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Search Fruit',
                      ),
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      onChanged: (value) {},
                      autofocus: true,
                    ),
                  ),
                  const Icon(Icons.search, color: Colors.grey),
                ],
              )),
        ),
      ),
    );
  }
}
