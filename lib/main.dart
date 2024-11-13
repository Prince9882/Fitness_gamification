import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:fitbeast_finalversion/features/app/splash_screen/splash_screen.dart';
import 'package:fitbeast_finalversion/features/user_auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //ensure binding with native platform

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(
          child: LoginScreen()
      ),
    );
  }
}

