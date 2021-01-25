import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/constants/constants.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:ishapp/screens/home_screen.dart';
import 'package:ishapp/screens/sign_up_screen.dart';
import 'package:ishapp/widgets/app_logo.dart';
import 'package:ishapp/widgets/cicle_button.dart';
import 'package:ishapp/widgets/default_button.dart';
import 'package:ishapp/widgets/svg_icon.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage("assets/images/background_image.jpg"),
             fit: BoxFit.fill,
             repeat: ImageRepeat.repeatY
           ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
             begin: Alignment.bottomRight, 

             colors: [
               Theme.of(context).primaryColor,
               Colors.black.withOpacity(.5)
             ]
           )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /// App logo
              AppLogo(),
              SizedBox(height: 10),

              /// App name
              Text(APP_NAME,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                  color: Colors.white)),
              SizedBox(height: 20),

              Text("welcome_back".tr(),
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 18,
                  color: Colors.white)),
              SizedBox(height: 5),
              Text("welcome_text".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 22),

              /// Sign in with Phone Number
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.maxFinite,
                  child: DefaultButton(
                    child: Text("continue".tr(),
                        style: TextStyle(fontSize: 18)),
                    onPressed: () {
                        /// Go to phone number screen
                      Navigator.of(context)
                          .popAndPushNamed(Routes.home);
                    },
                  ),
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: CircleButton(
                      bgColor: Colors.white,
                      padding: 10,
                      icon: SvgIcon("assets/icons/enter.svg",
                          width: 30, height: 30,
                          color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(Routes.signin);
                    },
                  ),
                  GestureDetector(
                    child: CircleButton(
                      bgColor: Colors.white,
                      padding: 10,
                      icon: SvgIcon("assets/icons/add-user.svg",
                          width: 30, height: 30,
                          color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(Routes.signup);
                    },
                  ),
                ],
              ),
              Text("or".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey)),

              SizedBox(height: 5),

              Text("sign_in_with_social_apps".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white60)),

              SizedBox(height: 10),

              /// Social login 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Login with facebook
                  GestureDetector(
                    child: CircleButton(
                      bgColor: Colors.white,
                      padding: 20,
                      icon: SvgIcon("assets/icons/facebook_icon.svg",
                          width: 30, height: 30, 
                          color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(Routes.signup);
                    },
                  ),

                  /// Login with google
                  GestureDetector(
                    child: CircleButton(
                      bgColor: Colors.white,
                      padding: 13,
                      icon: SvgPicture.asset("assets/icons/google_icon.svg",
                          width: 25, height: 25),
                    ),
                    onTap: () {
                        /// Go to sing up screen - for demo
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignUpScreen()));
                    },
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
