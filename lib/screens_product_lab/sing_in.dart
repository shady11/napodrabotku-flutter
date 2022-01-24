import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:ishtapp/datas/user.dart';
import 'package:ishtapp/routes/routes.dart';
import 'package:ishtapp/widgets/default_button.dart';
import 'package:ishtapp/widgets/svg_icon.dart';
import 'package:ishtapp/widgets/cicle_button.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/components/custom_button.dart';

class ProductLabSignIn extends StatefulWidget {
  const ProductLabSignIn({Key key}) : super(key: key);

  @override
  _ProductLabSignInState createState() => _ProductLabSignInState();
}

class _ProductLabSignInState extends State<ProductLabSignIn> {

  final _formKey = GlobalKey<FormState>();
  final _username_controller = TextEditingController();
  final _password_controller = TextEditingController();
  bool _obscureText = true;

  void _showDialog(context, String message) {
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
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  void _openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            content: Container(
                color: Colors.transparent,
                height: 50,
                width: 50,
                child: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(kColorPrimary),
                    ))),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sign_in_title".tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "sign_in".tr(),
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 40),

            /// Form
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Align(
                    widthFactor: 10,
                    heightFactor: 1.5,
                    alignment: Alignment.topLeft,
                    child: Text(
                      'email'.tr(),
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  TextFormField(
                    controller: _username_controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        filled: true,
                        fillColor: Colors.grey[200]),
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
                      child: Text(
                        'password'.tr(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )),
                  TextFormField(
                    obscureText: _obscureText,
                    controller: _password_controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
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
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, Routes.forgot_password);
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
                        // if (_formKey.currentState.validate()) {
                        //   _openLoadingDialog(context);
                        //
                        //   /// Remove previous screens
                        //   User user = new User();
                        //   user
                        //       .login(_username_controller.text,
                        //       _password_controller.text)
                        //       .then((value) {
                        //     if (value == "OK") {
                        //       Navigator.of(context)
                        //           .popUntil((route) => route.isFirst);
                        //       Navigator.of(context).pushNamed(Routes.home);
                        //     } else {
                        //       _showDialog(context,
                        //           "password_or_email_is_incorrect".tr());
                        //     }
                        //   });
                        // } else {
                        //   return 'Bum-shakalaka';
                        // }
                        Navigator.of(context).pushNamed(Routes.product_lab_home);
                      },
                      text: 'sign_in'.tr(),
                    ),
                  ),

                  // SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                  // Text("sign_in_with_social_apps".tr(),
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(fontSize: 16, color: Colors.black45)),

                  // SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  /// Social login
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       /// Login with google
//                       GestureDetector(
//                         child: CircleButton(
//                             bgColor: Colors.white,
//                             padding: 13,
//                             icon: Icon(Boxicons.bxl_google)
// //                    icon: SvgPicture.asset("assets/icons/google_icon.svg",
// //                        width: 20, height: 20, color: kColorPrimary,),
//                             ),
//                         onTap: () {
//                           /// Go to sing up screen - for demo
//                           Navigator.pushNamed(context, Routes.signup);
//                         },
//                       ),
//                       SizedBox(
//                         width: 30,
//                       ),

//                       /// Login with facebook
//                       GestureDetector(
//                         child: CircleButton(
//                             bgColor: Colors.white,
//                             padding: 13,
//                             icon: Icon(Boxicons.bxl_facebook_circle)
// //                    icon: SvgIcon("assets/icons/facebook_icon.svg",
// //                        width: 20, height: 20,
// //                        color: kColorPrimary),
//                             ),
//                         onTap: () {
//                           Navigator.of(context).pushNamed(Routes.signup);
//                         },
//                       ),
//                     ],
//                   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
