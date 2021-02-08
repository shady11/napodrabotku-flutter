import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:ishapp/constants/constants.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:ishapp/screens/home_screen.dart';
import 'package:ishapp/screens/sign_up_screen.dart';
import 'package:ishapp/widgets/app_logo.dart';
import 'package:ishapp/widgets/cicle_button.dart';
import 'package:ishapp/widgets/default_button.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/utils/some_painter.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/components/custom_button.dart';
import 'package:ishapp/datas/pref_manager.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        bottomSheet: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
//                margin: EdgeInsets.only(left: 10),
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                        'guest'.tr(),
                        style:  TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18
                        )
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).pushNamed(Routes.home);
                  },
                ),
              ),
//            CustomButton(
//              padding: EdgeInsets.all(10),
//              color: Colors.transparent,
//              textColor: kColorPrimary,
//              onPressed: () {
//                Navigator.of(context).popAndPushNamed(Routes.signup);
//              },
//              text: 'sign_up'.tr(),
//            ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Image.asset('assets/images/bb.png', fit: BoxFit.cover,),
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
                      Navigator.of(context).pushNamed(Routes.signin);
                    },
                    text: 'sign_in'.tr(),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),

              Text("sign_in_with_social_apps".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black45)),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              /// Social login
              Row(
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
              ),

            ],
          ),
        ),
      ),
    );
  }
}
