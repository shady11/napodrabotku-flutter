import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishtapp/components/custom_button.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/routes/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ishtapp/datas/pref_manager.dart';

class SelectMode extends StatefulWidget {
  const SelectMode({Key key}) : super(key: key);

  @override
  _SelectModeState createState() => _SelectModeState();
}

class _SelectModeState extends State<SelectMode> {
  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(context, msg: 'click_once_to_exit'.tr());
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBlue,
      body: WillPopScope(
        child: LayoutBuilder(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(height: 60),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "select_mode".tr(),
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 40),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomButton(
                                height: 50.0,
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding: EdgeInsets.all(10),
                                color: Colors.white,
                                textColor: kColorBlue,
                                textAlign: TextAlign.center,
                                onPressed: () {
                                  Prefs.setString(Prefs.ROUTE, "WORKER");
                                  Navigator.of(context).pushNamed(Routes.start);
                                },
                                text: 'Ищу работу',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                height: 70.0,
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding: EdgeInsets.all(10),
                                color: Colors.white,
                                textColor: kColorBlue,
                                textAlign: TextAlign.center,
                                onPressed: () {
                                  Prefs.setString(Prefs.ROUTE, "PRODUCT_LAB");
                                  Navigator.of(context).pushNamed(Routes.product_lab_start);
                                },
                                text: 'Хочу повысить \nквалификацию',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                height: 50.0,
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding: EdgeInsets.all(10),
                                textColor: Colors.white,
                                textAlign: TextAlign.center,
                                onPressed: () {
                                  Prefs.setString(Prefs.ROUTE, "COMPANY");
                                  Navigator.of(context).pushNamed(Routes.start);
                                },
                                text: 'Вход для компании',
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        onWillPop: onWillPop,
      ),
    );
  }
}
