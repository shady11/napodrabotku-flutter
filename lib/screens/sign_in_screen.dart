import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ishapp/constants/constants.dart';
import 'package:ishapp/screens/phone_number_screen.dart';
import 'package:ishapp/screens/sign_up_screen.dart';
import 'package:ishapp/widgets/app_logo.dart';
import 'package:ishapp/widgets/cicle_button.dart';
import 'package:ishapp/widgets/default_button.dart';
import 'package:ishapp/widgets/svg_icon.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

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

              Text("Welcome Back",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 18,
                  color: Colors.white)),
              SizedBox(height: 5),
              Text("Match with people around you",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 22),

              /// Sign in with Phone Number
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.maxFinite,
                  child: DefaultButton(
                    child: Text("Sign in with Phone Number",
                        style: TextStyle(fontSize: 18)),
                    onPressed: () {
                        /// Go to phone number screen
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PhoneNumberScreen()));
                    },
                  ),
                ),
              ),

              SizedBox(height: 20),

              Text("OR",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey)),

              SizedBox(height: 5),

              Text("Sign in with social apps",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white60)),

              SizedBox(height: 10),

              /// Social login 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Login with facebook
                  GestureDetector(
                    child: cicleButton(
                      bgColor: Colors.white,
                      padding: 20,
                      icon: SvgIcon("assets/icons/facebook_icon.svg",
                          width: 30, height: 30, 
                          color: Colors.blue),
                    ),
                    onTap: () {
                        /// Go to sing up screen - for demo
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignUpScreen()));
                    },
                  ),

                  /// Login with google
                  GestureDetector(
                    child: cicleButton(
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
