import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:ishtapp/datas/user.dart';
import 'package:ishtapp/routes/routes.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/components/custom_button.dart';
import 'package:ishtapp/datas/pref_manager.dart';

enum is_company { Company, User }

class SignInScreen extends StatefulWidget {

  final String routeFrom;
  SignInScreen({this.routeFrom});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username_controller = TextEditingController();
  final _password_controller = TextEditingController();
  final _phone_number_controller = TextEditingController();
  bool _obscureText = true;

  is_company company = is_company.User;

  String initialCountry = 'KG';
  PhoneNumber number = PhoneNumber(isoCode: 'KG');

  void _show_hide_password() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _showDialog(context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => Container(
        padding: EdgeInsets.all(20),
        child: AlertDialog(
          title: Text(''),
          content: Text(message),
          actions: <Widget>[
            CustomButton(
              height: 40.0,
              text: 'ok'.tr(),
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

  setMode() {
    setState(() {
      company = Prefs.getString(Prefs.ROUTE) == "COMPANY" ? is_company.Company : is_company.User;
    });
  }

  @override
  void initState() {
    setMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sign_in_title".tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "sign_in".tr(),
                  style: TextStyle(
                      fontSize: 24,
                      color: kColorDark,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
            ),

            /// Form
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  company == is_company.Company ?
                  /// Контакный Телефон
                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text(
                        company == is_company.Company ? 'Контактный телефон'.tr().toString().toUpperCase() : 'phone_number'.tr().toString().toUpperCase(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                        ),
                      )
                  ) :
                  /// Электронный адрес
                  Align(
                    widthFactor: 10,
                    heightFactor: 1.5,
                    alignment: Alignment.topLeft,
                    child: Text(
                      'email'.tr().toString().toUpperCase(),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),

                  company == is_company.Company ?
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: InternationalPhoneNumberInput(
                      countries: ['KG', 'RU', 'KZ', 'UA'],
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: true,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: _phone_number_controller,
                      formatInput: false,
                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                      inputDecoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[200],
                                width: 2.0
                            )
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kColorPrimary,
                                width: 2.0
                            )
                        ),
                        errorStyle: TextStyle(
                            color: kColorPrimary,
                            fontWeight: FontWeight.w500
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        filled: true,
                        fillColor: kColorWhite,
                      ),
                      locale: 'ru',
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ) :
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      controller: _username_controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[200],
                                width: 2.0
                            )
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kColorPrimary,
                                width: 2.0
                            )
                        ),
                        errorStyle: TextStyle(
                            color: kColorPrimary,
                            fontWeight: FontWeight.w500
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        filled: true,
                        fillColor: kColorWhite,
                      ),
                      validator: (name) {
                        // Basic validation
                        if (name.isEmpty) {
                          return "please_fill_this_field".tr();
                        }
                        return null;
                      },
                    ),
                  ),

                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text(
                        'password'.tr().toString().toUpperCase(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          fontWeight: FontWeight.w700
                        ),
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      obscureText: _obscureText,
                      controller: _password_controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[200],
                                width: 2.0
                            )
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        filled: true,
                        fillColor: kColorWhite,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kColorPrimary,
                                width: 2.0
                            )
                        ),
                        errorStyle: TextStyle(
                          color: kColorPrimary,
                          fontWeight: FontWeight.w500
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: kColorSecondary,
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
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.forgot_password);
                      },
                      child: Text(
                        'forgot_password'.tr(),
                        style: TextStyle(
                            fontSize: 14,
                            color: kColorDark,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  /// Sign In button
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      color: Prefs.getString(Prefs.ROUTE) == "PRODUCT_LAB" ?  kColorProductLab : kColorPrimary,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _openLoadingDialog(context);

                          /// Remove previous screens
                          User user = new User();
                          user.login(_username_controller.text,_password_controller.text).then((value) {
                            if(value == "OK") {
                              if(Prefs.getString(Prefs.ROUTE) == "PRODUCT_LAB") {
                                Navigator.of(context).popUntil((route) => route.isFirst);
                                Navigator.of(context).pushNamed(Routes.product_lab_home);
                              } else {
                                Navigator.of(context).popUntil((route) => route.isFirst);
                                Navigator.of(context).pushNamed(Routes.home);
                              }
                            } else {
                              _showDialog(context, "password_or_email_is_incorrect".tr());
                            }
                          });
                        } else {
                          return 'Bum-shakalaka';
                        }
                      },
                      text: 'sign_in'.tr(),
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
