import 'package:flutter/material.dart';

import 'shoe.dart';

class cart extends ChangeNotifier {
  List<Shoe> shoeshop = [
    Shoe(
        name: "Nike",
        price: "205",
        imagepath: "lib/images/a.jpg",
        description: "Comfy"),
    Shoe(
        name: "jordan",
        price: "500",
        imagepath: "lib/images/b.jpg",
        description: "FLY HIGH"),
    Shoe(
        name: "Vans",
        price: "150",
        imagepath: "lib/images/c.jpg",
        description: "Vans off the wall")
  ];

  List<Shoe> getshoelist() {
    return shoeshop;
  }

  List<Shoe> usercart = [];

  List<Shoe> getusercart() {
    return usercart;
  }

  void addtocart(Shoe shoe) {
    usercart.add(shoe);
    notifyListeners();
  }

  void removefromcart(Shoe shoe) {
    usercart.remove(shoe);
    notifyListeners();
  }
}
