import 'package:flutter/material.dart';
import 'package:fruma/log_form.dart';
import 'package:fruma/your_account.dart';
import 'package:fruma/your_orders.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: ListView(
            children: [
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                tileColor: Colors.grey[200],
                title: const Text(
                  'Your Account',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.person_outline),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const YourAccount()));
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                tileColor: Colors.grey[200],
                title: const Text(
                  'Your Orders',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.person_outline),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const YourOrders()));
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                tileColor: Colors.grey[200],
                title: const Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.person_outline),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onTap: () async {
                  SharedPreferences _pref = await SharedPreferences.getInstance();
                  _pref.remove('email');
                  _pref.remove('password');
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const LogForm()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
