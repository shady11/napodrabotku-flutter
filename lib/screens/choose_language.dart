import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/components/custom_button.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:ishapp/utils/constants.dart';

class ChooseLanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBlue,
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
                          'ishtapp',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Тил тандаңыз',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          'Выберите язык приложения',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CustomButton(
                              height:50.0,
                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              textColor: kColorBlue,
                              onPressed: () {
                                Prefs.setString(Prefs.LANGUAGE, 'ky');
                                EasyLocalization.of(context).locale =
                                EasyLocalization.of(context).supportedLocales[0];
                                Navigator.of(context).popAndPushNamed(Routes.start);
                              },
                              text: 'Кыргызча',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              height:50.0,
                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              textColor: kColorBlue,
                              onPressed: () {
                                Prefs.setString(Prefs.LANGUAGE, 'ru');
                                EasyLocalization.of(context).locale =
                                EasyLocalization.of(context).supportedLocales[1];
                                Navigator.of(context).popAndPushNamed(Routes.start);
                              },
                              text: 'Русский',
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