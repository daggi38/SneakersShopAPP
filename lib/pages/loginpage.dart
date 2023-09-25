import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sneakers/components/textfields.dart';
import 'package:sneakers/pages/homepage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({
    super.key,
  });

  @override
  State<Loginpage> createState() => _LoginpageState();
}

bool obsecure = true;

class _LoginpageState extends State<Loginpage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  void signin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text, password: passwordcontroller.text);
    if (FirebaseAuth.instance.currentUser != null) {
      print("success");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:const  BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                colors: [Colors.red, Colors.white])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        const    Text("D Shoes",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 50,
                    fontWeight: FontWeight.bold)),
            My(
              onTap: () {},
              suffixicon: false,
              mycontroller: emailcontroller,
              hinttext: "Enter your email",
              hidepassword: false,
            ),
           const SizedBox(
              height: 20,
            ),
            My(
                onTap: () {
                  setState(() {
                    obsecure = !obsecure;
                  });
                },
                suffixicon: true,
                mycontroller: passwordcontroller,
                hinttext: "Password",
                hidepassword: obsecure),
          const  SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 173, 136, 122),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: signin,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 216, 72, 72),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: MediaQuery.of(context).size.width / 1.5,
                child:const  Center(
                  child:  Text("Sign In",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
         const    SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Text(
                  "Dont have an account?",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              ' Or Login with',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "I just wanna visit ",
                  style: TextStyle(color: Colors.white),
                ),
                IconButton(
                  icon: Icon(
                    size: 30,
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => homepage()));
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
