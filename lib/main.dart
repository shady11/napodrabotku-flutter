import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ishapp/screens/sign_in_screen.dart';

import 'constants/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
      theme: ThemeData(
        primaryColor: Colors.orange[300],
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
            errorStyle: TextStyle(fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
            )),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: Platform.isIOS ? 0 : 4.0,
          iconTheme: IconThemeData(color: Colors.black),
          brightness: Brightness.light,
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
