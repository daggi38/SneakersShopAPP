import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:sneakers/components/vavbar.dart';
import 'package:sneakers/drawer/drawer.dart';
import 'package:sneakers/views.dart/shopview.dart';
import 'package:sneakers/views.dart/cartview.dart';

class homepage extends StatefulWidget {
  homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int selectedindex = 0;

  void navigate(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  final List<Widget> pages = [Shopview(), Cartview()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mydrawer(
          inital: FirebaseAuth.instance.currentUser != null
              ? FirebaseAuth.instance.currentUser!.email.toString()
              : "Sign in"),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: mysearch());
              },
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          child: Builder(
            builder: (context) => IconButton(
                color: Colors.black,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu)),
          ),
        ),
        elevation: 0,
      ),
      body: pages[selectedindex],
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: myynavbar(
        onTabChange: navigate,
      ),
    );
  }
}
