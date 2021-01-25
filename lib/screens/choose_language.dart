import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/components/custom_button.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/routes/routes.dart';

class ChooseLanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 60,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Добро пожаловать!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Выберите язык приложения',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          'Кош келиңиздер!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Тиркеменин тилин тандаңыз',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CustomButton(
                              padding: EdgeInsets.all(20),
                              onPressed: () {
                                Prefs.setString(Prefs.LANGUAGE, 'ru');
                                EasyLocalization.of(context).locale =
                                EasyLocalization.of(context).supportedLocales[1];
                                Navigator.of(context).popAndPushNamed(Routes.signin);
                              },
                              text: 'Русский',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              padding: EdgeInsets.all(20),
                              onPressed: () {
                                Prefs.setString(Prefs.LANGUAGE, 'ky');
                                EasyLocalization.of(context).locale =
                                EasyLocalization.of(context).supportedLocales[0];
                                Navigator.of(context).popAndPushNamed(Routes.signin);
                              },
                              text: 'Кыргызча',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}