import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:ishapp/utils/app_themes.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/utils/themebloc/theme_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), () => {_loadScreen()});
  }

  _loadScreen() async {
    await Prefs.load();
    context.bloc<ThemeBloc>().add(ThemeChanged(
        theme: Prefs.getBool(Prefs.DARKTHEME, def: false)
            ? AppTheme.DarkTheme
            : AppTheme.LightTheme));
    if(Prefs.getString('language') == null)
      Navigator.of(context).pushReplacementNamed(Routes.chooseLanguage);
    else {
      Navigator.of(context).pushReplacementNamed(Routes.start);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Theme.of(context).splashColor,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'ishtapp',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
