import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:sneakers/pages/homepage.dart';
import 'package:sneakers/pages/loginpage.dart';

class Authgate extends StatefulWidget {
  const Authgate({super.key});

  @override
  State<Authgate> createState() => _AuthgateState();
}

class _AuthgateState extends State<Authgate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return homepage();
              } else {
                return Loginpage();
              }
            }));
  }
}
