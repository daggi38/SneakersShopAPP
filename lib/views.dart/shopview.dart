import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneakers/auth.dart';
import 'package:sneakers/components/Constraints.dart';
import 'package:sneakers/components/Skeleton.dart';
import 'package:sneakers/components/shoetile.dart';
import 'package:sneakers/models/cart.dart';
import 'package:sneakers/models/shoe.dart';

class Shopview extends StatefulWidget {
  const Shopview({super.key});

  @override
  State<Shopview> createState() => _ShopviewState();
}

late bool _isLoading;
final searchquery = TextEditingController();

class _ShopviewState extends State<Shopview> {
  // void initState() {
  //   _isLoading = true;
  //   Future.delayed(const Duration(seconds: 5), () {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  void addtocart(name, price, image) {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection("mycart")
        .doc(name)
        .set({"name": name, "image": image, "price": price});
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Item  added successfully')));
  }

  void addshoe(Shoe shoe) {
    Provider.of<cart>(context, listen: false).addtocart(shoe);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Shoes added to Cart"),
            ));
  }

  void isnull() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Sign in required"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Authgate()));
                    },
                    child: Text("Sign in")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Continue"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<cart>(
        builder: (context, value, child) => SingleChildScrollView(
              child: Column(
                children: [
                  //search bar

                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Everyone flies.. some fly longer than others",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hot Picks ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text("See all")
                      ],
                    ),
                  ),

                  Container(
                    height: 350,
                    child: _builduserlist(),
                  ),

                  const Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "ON SALE ",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 350,
                    child: _buildnewuserlist(),
                  )
                ],
              ),
            ));
  }

  Widget _builduserlist() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('shoes')
            .where("status", isNotEqualTo: "onsale")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs
                  .map((e) => builderuserlistitem(e))
                  .toList(),
            );
          }
          // if (snapshot.connectionState == ConnectionState.waiting)
          //   return NewsCardSkelton();

          return Container();
        });
  }

  Widget _buildnewuserlist() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('shoes')
            .where("status", isEqualTo: "onsale")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs
                  .map((e) => builderuserlistitem(e))
                  .toList(),
            );
          }
          // if (snapshot.connectionState == ConnectionState.waiting)
          //   return NewsCardSkelton();

          return Container();
        });
  }

  Widget builderuserlistitem(
    DocumentSnapshot document,
  ) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    return Shoetile(
      shoe: Shoe(
          name: data["name"],
          price: data["price"],
          imagepath: data["image"].toString(),
          description: data["description"]),
      onTap: () {
        FirebaseAuth.instance.currentUser != null
            ? addtocart(data["name"], data["price"], data["image"])
            : isnull();
      },
    );
  }
}

class mysearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _builduserlist();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Widget _builduserlist() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('shoes')
            .where('name'.toString(), isGreaterThanOrEqualTo: query.toString())
            .where('name'.toString(),
                isLessThanOrEqualTo: query.toString() + '\uf8ff')

            // explain the above code

            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => builderuserlistitem(doc, context))
                .toList(),
          );
        });
  }

  Widget builderuserlistitem(
    DocumentSnapshot document,
    BuildContext context,
  ) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    return Shoetile(
      shoe: Shoe(
          name: data["name"],
          price: data["price"],
          imagepath: data["image"].toString(),
          description: data["description"]),
      onTap: () {
        //   FirebaseAuth.instance.currentUser != null
        //       ? addtocart(data["name"], data["price"], data["image"])
        //       : isnull();
      },
    );
  }
}
