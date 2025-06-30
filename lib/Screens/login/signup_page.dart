import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();
  var cnfPasswordController = TextEditingController();
  bool isPassVisible = false;
  bool isCnfPassVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: [
              Expanded(flex: 1,child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Center(
                      child: Image.asset(
                        "assets/images/ic_logo.png",
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),SizedBox(height: 20,),
                  Center(
                    child: Container(
                      alignment: AlignmentDirectional(0, 3),
                      width: double.infinity,
                      height: 100,
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
              Expanded(flex: 2,child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      hintText: "Enter name.",
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
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
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      hintText: "Enter mobile no..",
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
                    obscureText: !isPassVisible,
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
                        isPassVisible = !isPassVisible;
                        setState(() {});
                      },
                          icon: Icon(isPassVisible ? Icons.visibility : Icons
                              .visibility_off,)),
                    ),
                  ), SizedBox(height: 20),
                  TextField(
                    controller: cnfPasswordController,
                    obscureText: !isCnfPassVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      hintText: "Confirm password.",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      suffixIcon: IconButton(onPressed: () {
                        isCnfPassVisible = !isCnfPassVisible;
                        setState(() {});
                      },
                          icon: Icon(isCnfPassVisible ? Icons.visibility : Icons
                              .visibility_off,)),
                    ),
                  ), SizedBox(height: 20),
                  Container(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(onPressed: () async{
                      try{
                        FirebaseAuth mAuth = FirebaseAuth.instance;
                        UserCredential mUsers =  await mAuth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                        if(mUsers.user!=null){
                          ///Navigate to Login Page
                          print("User Created Successfully : ${mUsers.user!.uid}");
                          /// Create a User Profile
                          /// Store in Firebase fireStore.
                          FirebaseFirestore.instance.collection("users").doc(mUsers.user!.uid).set({
                            'email' : emailController,
                            'name' : nameController,
                            'mobile_n0' : mobileController,
                            'created_at' : DateTime.now().millisecondsSinceEpoch,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup Successfully")));
                          Navigator.pop(context);
                        }

                      } on FirebaseAuthException catch(e){
                        /// on Firebase Auth Exception

                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The password provided is too weak.")));
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The account already exists for that email.")));
                        } else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Firebase Auth Exception : ${e.toString()}")));
                        }
                      } catch(e){
                        /// on Exception
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                      }
                    }, style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ), child: isLoading ? Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 10,),
                        Text("Registering user")
                      ],
                    ) : Text("Sign Up")),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}