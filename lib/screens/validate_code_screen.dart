import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:ishapp/datas/pref_manager.dart';

import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/components/custom_button.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/routes/routes.dart';

class ValidateCodeScreen extends StatefulWidget {
  @override
  _ValidateCodeScreenState createState() => _ValidateCodeScreenState();
}

class _ValidateCodeScreenState extends State<ValidateCodeScreen> {
  final _code_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: kColorPrimary,
      appBar: AppBar(
        title: Text("validate_code".tr()),
      ),
      body:
      SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Center(
                  child: Text('validate_code_info_text'.tr(),
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
                  child: Text('code'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
              TextFormField(
                controller: _code_controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (name) {
                  if (name.isEmpty) {
                    return "please_fill_this_field".tr();
                  }
                  else if(name.length!=6){
                    return "code_must_be_6_digit".tr();
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              CustomButton(
                padding: EdgeInsets.all(15),
                color: kColorPrimary,
                textColor: Colors.white,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    User.validateUserCode(code: _code_controller.text, email: Prefs.getString(Prefs.EMAIL)).then((value) {
                      if(value =="OK"){
                        Navigator.pushNamed(context, Routes.new_password);
                      }
                    });
                  }
                  else{
                    return;
                  }
                },
                text: 'validate'.tr(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
