import 'dart:async';
import 'package:chat_bot/Screens/dashboard/initial_page.dart';
import 'package:chat_bot/Screens/login/login_page.dart';
import 'package:chat_bot/utils/utils_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SplashScreen> {

  bool isLoggedIn = false;
  String? userId;

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 2), () {
      if(!isLoggedIn){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => InitialPage()),);
      } else{
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginPage()),);
      }
      getUserId();
    });
  }

  void getUserId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("uid", "$userId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Image.asset("assets/images/ic_logo.png", width: 80, height: 80),
      ),
    );
  }
}
