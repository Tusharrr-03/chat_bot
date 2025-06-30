import 'package:chat_bot/Screens/dashboard/initial_page.dart';
import 'package:chat_bot/Screens/login/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: Center(
                child: Image.asset(
                  "assets/images/ic_logo.png",
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      hintText: "Enter mail.",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ), SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      hintText: "Enter password.",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      suffixIcon: IconButton(onPressed: () {
                        isVisible = !isVisible;
                        setState(() {});
                      },
                          icon: Icon(isVisible ? Icons.visibility : Icons
                              .visibility_off,)),
                    ),
                  ), SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    alignment: Alignment(1, 0),
                    child: TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => SignUpPage()));
                    }, child: Text("Sign Up?", style: TextStyle(color: Colors.blueAccent),)),
                  ), SizedBox(height: 20,),
                  Container(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(onPressed: () async {
                      String email = emailController.text;
                      String password = passwordController.text;
                      try {
                        FirebaseAuth mAuth = FirebaseAuth.instance;
                        UserCredential userCred =  await mAuth.signInWithEmailAndPassword(email: email, password: password);
                        if(userCred.user!=null){
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("uid", userCred.user!.uid);

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InitialPage()));
                        }
                      } on FirebaseAuthException catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text("Invalid Credential"))));
                      } catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error : ${e.toString()}")));
                      }
                    }, style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ), child: Text("Login")),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}