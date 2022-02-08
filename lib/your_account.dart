import 'package:flutter/material.dart';
import 'package:fruma/provider_controller.dart';
import 'package:provider/provider.dart';

class YourAccount extends StatefulWidget {
  const YourAccount({Key? key}) : super(key: key);

  @override
  State<YourAccount> createState() => _YourAccountState();
}

class _YourAccountState extends State<YourAccount> {
  String name = 'New User';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Your Account',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 70,
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const ListTile(
              title: Text(
                'Your Information',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              tileColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: const Text(
                'Email',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                '${Provider.of<MyProvider>(context).userData['email']}',
                style: const TextStyle(fontSize: 15),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              tileColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: const Text(
                'Country',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: const Text(
                'Egypt',
                style: TextStyle(fontSize: 15),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              tileColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: const Text(
                'City',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: const Text(
                'Alexandria',
                style: TextStyle(fontSize: 15),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              tileColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: const Text(
                'Address',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: const Text(
                'Agami, Hanoveal',
                style: TextStyle(fontSize: 15),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              tileColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: const Text(
                'Password',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                '${Provider.of<MyProvider>(context).userData['password']}',
                style: const TextStyle(fontSize: 15),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
