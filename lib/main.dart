import 'package:chat_bot/Screens/dashboard/bloc/chat_bloc.dart';
import 'package:chat_bot/Screens/login/login_page.dart';
import 'package:chat_bot/Screens/splash_screen.dart';
import 'package:chat_bot/data/remote/helper/api_helper.dart';
import 'package:chat_bot/data/repository/chat_repo.dart';
import 'package:chat_bot/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

final apiKey = const String.fromEnvironment('API_Key');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print("Firebase Initialize");
  } catch(e){
    print("Firebase Init Error :$e");
  }
  Gemini.init(apiKey: apiKey, enableDebugging: true);
  runApp(
    BlocProvider(
      create:
          (context) => ChatBloc(
            chatRepo: ChatRepo(
              apiHelper: ApiHelper(),
              firebaseFirestore: FirebaseFirestore.instance,
            ),
          ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        /// dark Theme Manage
      ),
      theme: ThemeData(
        /// light Theme managed
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
