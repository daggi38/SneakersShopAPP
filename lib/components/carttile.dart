import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneakers/models/cart.dart';

import '../models/shoe.dart';

class carttile extends StatefulWidget {
  Shoe shoe;
  carttile({super.key, required this.shoe});

  @override
  State<carttile> createState() => _carttileState();
}

class _carttileState extends State<carttile> {
  void removeitem() {
    Provider.of<cart>(context, listen: false).removefromcart(widget.shoe);
    print("hvhvhvh");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 219, 216, 216),
      child: ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.shoe.imagepath,
            )),
        title: Text(widget.shoe.name),
        subtitle: Text(widget.shoe.price),
        trailing: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            removeitem();
          },
        ),
      ),
    );
  }
}
