import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sneakers/components/carttile.dart';

import 'package:sneakers/models/cart.dart';
import 'package:sneakers/models/shoe.dart';

class Cartview extends StatefulWidget {
  const Cartview({super.key});

  @override
  State<Cartview> createState() => _CartviewState();
}

class _CartviewState extends State<Cartview> {
  @override
  Widget build(BuildContext context) {
    return Consumer<cart>(
        builder: (context, value, child) => Column(
              children: [
                Text(
                  "M Y  C A R T",
                  style: TextStyle(fontSize: 20),
                ),
                // Expanded(
                //     child: ListView.builder(
                //         itemCount: value.getusercart().length,
                //         itemBuilder: ((context, index) {
                //           Shoe indshoe = value.getusercart()[index];
                //           return carttile(shoe: indshoe)
                //         })))

                Container(
                    height: 300,
                    width: 400,
                    child: FirebaseAuth.instance.currentUser != null
                        ? _buildnewuserlist()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Sign in to view your cart")]))
              ],
            ));
  }

  Widget _buildnewuserlist() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("mycart")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((document) {
                final docdata = document.data() as Map<String, dynamic>;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: builderuserlistitem(document),
                );
              }).toList(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget builderuserlistitem(
    DocumentSnapshot document,
  ) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    return Slidable(
      endActionPane: ActionPane(motion: StretchMotion(), children: [
        SlidableAction(
            onPressed: (context) {
              FirebaseFirestore.instance
                  .collection('cart')
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("mycart")
                  .doc(data["name"])
                  .delete();

              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item removed successfully')));
            },
            backgroundColor: Colors.red,
            icon: Icons.delete),
      ]),
      child: carttile(
          shoe: Shoe(
              description: "description",
              name: data["name"],
              imagepath: data["image"].toString(),
              price: data["price"])),
    );
  }
}
