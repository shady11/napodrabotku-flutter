import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';

import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/components/custom_button.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:ishapp/datas/pref_manager.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  @override
  _ForgotPasswordEmailScreenState createState() => _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final _email_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isValid =false;

  void _openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            content: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(kColorPrimary),),
                )
            ),
          ),
        );
      },
    );
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
              child: Text('continue'.tr()),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: kColorPrimary,
      appBar: AppBar(
        title: Text("password_forgot_email".tr()),
      ),
      body:
      SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Center(
                  child: Text('password_email_info_text'.tr(),
                    style: TextStyle(
                        fontSize: 18,
                        color: kColorPrimary,
                        fontWeight: FontWeight.w700,
//                        fontStyle: FontStyle.italic
                    ),
                  )
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Align(
                    widthFactor: 10,
                    heightFactor: 1.5,
                    alignment: Alignment.topLeft,
                    child: Text('email'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                TextFormField(
                  controller: _email_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value){
                    isValid = EmailValidator.validate(value);
                  },
                  validator: (name) {
                    if (name.isEmpty) {
                      return "please_fill_this_field".tr();
                    }
                    else if(!isValid){
                      return "please_write_valid_email".tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                CustomButton(
                  padding: EdgeInsets.all(15),
                  color: kColorPrimary,
                  textColor: Colors.white,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _openLoadingDialog(context);
                      User.sendMailOnForgotPassword(_email_controller.text).then((value) {
                        Prefs.setString(Prefs.EMAIL, _email_controller.text);
                        if(value =="OK"){
                          Navigator.pushNamed(context, Routes.validate_code);
                        }
                        else{
                          _showDialog(context, "some_error_occurred_please_try_again".tr());
                        }
                      });
                    }
                    else{
                      return;
                    }
                  },
                  text: 'continue'.tr(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
