import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sneakers/drawer/drawertile.dart';
import 'package:sneakers/pages/loginpage.dart';

class mydrawer extends StatefulWidget {
  final String inital;
  const mydrawer({super.key, required this.inital});

  @override
  State<mydrawer> createState() => _mydrawerState();
}

class _mydrawerState extends State<mydrawer> {
  void signout() {
    FirebaseAuth.instance.signOut();
  }

  void navigateback() {
    Navigator.push(context as BuildContext,
        MaterialPageRoute(builder: (context) => Loginpage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Drawer(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Color.fromARGB(255, 239, 234, 234),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => MyProfilePage()));
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              color: Color.fromARGB(255, 172, 200, 200),
                              child: Center(
                                  child: Text(
                                widget.inital
                                    .toString()
                                    .characters
                                    .first
                                    .toUpperCase(),
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.inital,
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          colors: [Colors.red, Colors.white])),
                  child: Column(
                    children: [
                      Drawertile(listtitle: "Contacts"),
                      Drawertile(listtitle: "Folders"),
                      GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.currentUser != null
                                ? signout()
                                : navigateback();
                          },
                          child: Drawertile(listtitle: "Log out")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
