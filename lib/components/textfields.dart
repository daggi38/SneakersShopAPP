import 'package:flutter/material.dart';
import 'package:sneakers/pages/loginpage.dart';

class My extends StatelessWidget {
  final TextEditingController mycontroller;
  String hinttext;
  bool suffixicon;
  bool hidepassword;
  void Function() onTap;

  My(
      {super.key,
      required this.onTap,
      required this.hinttext,
      required this.hidepassword,
      required this.mycontroller,
      required this.suffixicon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: mycontroller,
        style: TextStyle(color: Colors.white),
        obscureText: hidepassword,
        decoration: InputDecoration(
          suffixIcon: suffixicon
              ? GestureDetector(
                  onTap: () {
                    onTap();
                  },
                  child: Icon(
                    obsecure ? Icons.visibility : Icons.visibility_off,
                    color: Color.fromARGB(255, 193, 113, 108),
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
