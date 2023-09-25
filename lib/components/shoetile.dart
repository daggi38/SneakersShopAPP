import 'package:flutter/material.dart';
import 'package:sneakers/models/shoe.dart';

class Shoetile extends StatelessWidget {
  void Function()? onTap;
  Shoe shoe;
  Shoetile({super.key, required this.shoe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(left: 25),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 180,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                shoe.imagepath,
                fit: BoxFit.contain,
              )),
        ),
        SizedBox(
          height: 20,
        ),
        Text(shoe.description,
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    shoe.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("\$" + shoe.price,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                      )),
                ],
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.orange,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
