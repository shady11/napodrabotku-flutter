import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:ishapp/widgets/default_button.dart';
import 'package:ishapp/widgets/svg_icon.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sign_in".tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text("sign_in".tr(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            /// Form
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  /// Fullname field
                  TextFormField(
                    controller: _username_controller,
                    decoration: InputDecoration(
                        labelText: "username".tr(),
                        hintText: "enter_your_username".tr(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgIcon("assets/icons/user_icon.svg"),
                        )),
                    validator: (name) {
                      // Basic validation
                      if (name.isEmpty) {
                        return "please_fill_this_field".tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  /// School field
                  TextFormField(
                    controller: _password_controller,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        labelText: "password".tr(),
                        hintText: "enter_your_password".tr(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: SvgIcon("assets/icons/password.svg"),
                        ),
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
                    validator: (school) {
                      if (school.isEmpty) {
                        return "please_fill_this_field".tr();
                      }
                      else if (school.length <5) {
                        return "password_must_at_least_5_chars".tr();
                      }
                      return null;
                    },
                    ),
                  SizedBox(height: 20),
                  /// Sign In button
                  SizedBox(
                    width: double.maxFinite,
                    child: DefaultButton(
                      child: Text("sign_in".tr(), style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        /// Validate form
//                         if (_formKey.currentState.validate()) {
//                           /// Remove previous screens
//                           Navigator.of(context)
//                               .popUntil((route) => route.isFirst);
//                           User user = new User();
//                           user.login(_username_controller.text, _password_controller.text);
//                           Navigator.of(context)
//                               .pushNamed(Routes.home);
//                         }
//                         else{
//                           return;
//                         }
                        Navigator.of(context)
                               .popUntil((route) => route.isFirst);
                        Navigator.of(context)
                               .pushNamed(Routes.home);
                      },
                    ),
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
