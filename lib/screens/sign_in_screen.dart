import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:ishapp/datas/user.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:ishapp/widgets/default_button.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/widgets/cicle_button.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/components/custom_button.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username_controller = TextEditingController();
  final _password_controller = TextEditingController();
  bool _obscureText = true;

  void _show_hide_password() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _showDialog(context,String message) {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        child: AlertDialog(
          title: Text(''),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'.tr()),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("dont_have_account".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black45)),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: InkWell(
                child: Text(
                    'sign_up'.tr(),
                    style:  TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18
                    )
                ),
                onTap: (){
                  Navigator.of(context).popAndPushNamed(Routes.signup);
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
      ),*/
      appBar: AppBar(
        title: Text("sign_in_title".tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Align(

              alignment: Alignment.topLeft,
              child: Text("sign_in".tr(),
                  style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
            ),
            SizedBox(height: 40),

            /// Form
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  /// Fullname field
                  Align(
                    widthFactor: 10,
                    heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('email'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                  TextFormField(
                    controller: _username_controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      fillColor: Colors.grey[200]
                    ),
                    validator: (name) {
                      // Basic validation
                      if (name.isEmpty) {
                        return "please_fill_this_field".tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('password'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                  TextFormField(
                    obscureText: _obscureText,
                    controller: _password_controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      fillColor: Colors.grey[200],
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (password) {
                      // Basic validation
                      if (password.isEmpty) {
                        return "please_fill_this_field".tr();
                      }
//                      else if (password.length <5) {
//                        return "password_must_at_least_5_chars".tr();
//                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.forgot_password);
                      },
                      child: Text('forgot_password'.tr()),
                    ),
                  ),
                  SizedBox(height: 30),
                  /// Sign In button
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      padding: EdgeInsets.all(15),
                      color: kColorPrimary,
                      textColor: Colors.white,
                      onPressed: () {
                         if (_formKey.currentState.validate()) {
                           /// Remove previous screens
                           User user = new User();
                           user.login(_username_controller.text, _password_controller.text).then((value) {
                             if(value == "OK"){
                               Navigator.of(context)
                                   .popUntil((route) => route.isFirst);
                               Navigator.of(context)
                                   .pushNamed(Routes.home);
                             }
                             else{
                               _showDialog(context, "password_or_email_is_incorrect".tr());
                             }
                           });

                         }
                         else{
                           return 'Bum-shakalaka';
                         }
                      },
                      text: 'sign_in'.tr(),
                    ),
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
                          Navigator.pushNamed(context, Routes.signup);
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
          ],
        ),
      ),
    );
  }
}
