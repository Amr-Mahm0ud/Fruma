import 'package:flutter/material.dart';
import 'package:fruma/buy_fruit.dart';
import 'package:fruma/more_fruits.dart';
import 'package:fruma/provider_controller.dart';
import 'package:fruma/search_page.dart';
import 'package:fruma/settings.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Fruma',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.amberAccent.withOpacity(0.6),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const Settings()));
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black54,
                    size: 20,
                  )),
            ),
          ),
        ],
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
                        autofocus: false,
                        readOnly: true,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const SearchPage()));
                        }),
                  ),
                  const Icon(Icons.search, color: Colors.grey),
                ],
              )),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            buildListTile('Our Store', context),
            buildSizedBox(context),
            const SizedBox(height: 30),
            buildListTile('Best Summer Fruits', context),
            buildSizedBox(context),
            const SizedBox(height: 30),
            buildListTile('Most Selling', context),
            buildSizedBox(context),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.white.withOpacity(0.91),
              blurRadius: 2,
              spreadRadius: 0,
              offset: const Offset(0, 3))
        ]),
        child: BottomNavigationBar(
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
        ),
      ),

    );
  }

  SizedBox buildSizedBox(BuildContext ctx) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () {
                Navigator.of(ctx).push(MaterialPageRoute(
                  builder: (_) =>
                      BuyFruit(Provider.of<MyProvider>(ctx).fruits[index]),
                ));
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
                      Provider.of<MyProvider>(context).fruits[index].imgSrc,
                      scale: 4,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      Provider.of<MyProvider>(context).fruits[index].name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      Provider.of<MyProvider>(context).fruits[index].price.toString(),
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  ListTile buildListTile(String title, BuildContext ctx) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
      onTap: () {
        Navigator.of(ctx)
            .push(MaterialPageRoute(builder: (_) => MoreFruits(title)));
      },
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'More Fruit',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            Icon(
              Icons.arrow_forward,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
