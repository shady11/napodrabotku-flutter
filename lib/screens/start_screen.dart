import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:ishtapp/constants/constants.dart';
import 'package:ishtapp/routes/routes.dart';
import 'package:ishtapp/screens/home_screen.dart';
import 'package:ishtapp/screens/sign_up_screen.dart';

// import 'package:ishtapp/widgets/app_logo.dart';
import 'package:ishtapp/widgets/cicle_button.dart';
import 'package:ishtapp/widgets/default_button.dart';
import 'package:ishtapp/widgets/svg_icon.dart';
import 'package:ishtapp/utils/some_painter.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/components/custom_button.dart';
import 'package:ishtapp/datas/pref_manager.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  DateTime currentBackPressTime;

  String mode;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(context, msg: 'click_once_to_exit'.tr());
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void initState() {
    mode = Prefs.getString(Prefs.ROUTE);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        // bottomSheet: Container(
        //   color: Colors.white,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Container(
        //         margin: EdgeInsets.only(bottom: 15),
        //         child: InkWell(
        //           child: Padding(
        //             padding: const EdgeInsets.all(20),
        //             child: Text('guest'.tr(),
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.normal, fontSize: 18)),
        //           ),
        //           onTap: () {
        //             Navigator.of(context).pushNamed(Routes.home);
        //           },
        //         ),
        //       ),
//            CustomButton(
//              padding: EdgeInsets.all(10),
//              color: Colors.transparent,
//              textColor: kColorPrimary,
//              onPressed: () {
//                Navigator.of(context).popAndPushNamed(Routes.signup);
//              },
//              text: 'sign_up'.tr(),
//            ),
//                 ],
//               ),
//             ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Image.asset(
                    'assets/images/welcome.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Sign in with Phone Number
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    padding: EdgeInsets.all(10),
                    color: Color(0xffF2F2F5),
                    textColor: kColorBlue,
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.signup);
                    },
                    text: 'sign_up'.tr(),
                  ),
                  CustomButton(
                    padding: EdgeInsets.all(10),
                    color: kColorPrimary,
                    textColor: Colors.white,
                    onPressed: () {
                      Prefs.setString(Prefs.ROUTE, "ISHTAPP");
                      Navigator.of(context).pushNamed(Routes.signin);
                    },
                    text: 'sign_in'.tr(),
                  ),
                ],
              ),

              SizedBox(height: 10),

              mode == "COMPANY"
                  ? Container()
                  : InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('guest'.tr(), style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
                      ),
                      onTap: () {
                        if(mode == "PRODUCT_LAB")
                          Navigator.of(context).pushNamed(Routes.product_lab_home);
                        else
                          Navigator.of(context).pushNamed(Routes.home);
                      },
                    ),

              SizedBox(height: 10),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: SizedBox(
                        height: 60,
                        child: Image.asset('assets/images/partners/japan.png'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: SizedBox(
                        height: 60,
                        child: Image.asset('assets/images/partners/giz.gif'),
                      ),
                    ),
                    Container(
                      child: SizedBox(
                        height: 60,
                        child: Image.asset('assets/images/partners/undp.png'),
                      ),
                    ),
                  ],
                ),
              ),

              /// Social login
              /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Login with google
            GestureDetector(
              child: CircleButton(
                bgColor: Colors.white,
                padding: 13,
                icon: Icon(Boxicons.bxl_google)
//                    icon: SvgPicture.asset("assets/icons/google_icon.svg",
//                        width: 20, height: 20, color: kColorPrimary,),
              ),
              onTap: () {
                  /// Go to sing up screen - for demo
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SignUpScreen()));
              },
            ),
            SizedBox(
              width: 30,
            ),
            /// Login with facebook
            GestureDetector(
              child: CircleButton(
                bgColor: Colors.white,
                padding: 13,
                icon: Icon(Boxicons.bxl_facebook_circle)
//                    icon: SvgIcon("assets/icons/facebook_icon.svg",
//                        width: 20, height: 20,
//                        color: kColorPrimary),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(Routes.signup);
              },
            ),
          ],
        ),*/
            ],
          ),
        ),
      ),
    );
  }
}
