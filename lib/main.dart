import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sneakers/auth.dart';
import 'package:sneakers/firebase_options.dart';
import 'package:sneakers/models/cart.dart';
import 'package:sneakers/pages/homepage.dart';
import 'package:provider/provider.dart';
import 'package:sneakers/pages/loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => cart(),
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Authgate(),
            ));
  }
}
