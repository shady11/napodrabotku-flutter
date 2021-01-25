import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:ishapp/screens/home_screen.dart';
import 'package:ishapp/screens/sign_in_screen.dart';
import 'package:ishapp/screens/sign_up_screen.dart';
import 'package:ishapp/screens/start_screen.dart';
import 'package:ishapp/screens/splash_screen.dart';
import 'package:ishapp/screens/choose_language.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return CupertinoPageRoute(builder: (_) => SplashScreen());

      case Routes.chooseLanguage:
        return CupertinoPageRoute(builder: (_) => ChooseLanguageScreen());

      case Routes.start:
        return CupertinoPageRoute(builder: (_) => StartScreen());

      case Routes.signin:
        return CupertinoPageRoute(builder: (_) => SignInScreen());

      case Routes.signup:
        return CupertinoPageRoute(builder: (_) => SignUpScreen());

      case Routes.home:
        return CupertinoPageRoute(builder: (_) => HomeScreen());

      case Routes.error:
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('new_page'.tr()),
        ),
        body: Center(
          child: Text('new_page'.tr()),
        ),
      );
    });
  }
}