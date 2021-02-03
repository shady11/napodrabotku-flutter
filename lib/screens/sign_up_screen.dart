import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/routes/routes.dart';

import 'package:ishapp/widgets/default_button.dart';
import 'package:ishapp/widgets/show_scaffold_msg.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/components/custom_button.dart';

import 'home_screen.dart';

enum is_company { Company, User}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Variables
  final _formKey = GlobalKey<FormState>();
  final _username_controller = TextEditingController();
  final _name_controller = TextEditingController();
  final _surnname_controller = TextEditingController();
  final _email_controller = TextEditingController();
  final _phone_number_controller = TextEditingController();
  final _password_controller = TextEditingController();
  final _password_confirm_controller = TextEditingController();
  final _linked_link_controller = TextEditingController();
  bool _obscureText = true;

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;
  String _retrieveDataError;

  void _showDataPicker() {
    DatePicker.showDatePicker(context,
        theme: DatePickerTheme(
          headerColor: Theme.of(context).primaryColor,
          cancelStyle: const TextStyle(color: Colors.white, fontSize: 17),
          doneStyle: const TextStyle(color: Colors.white, fontSize: 17),
        ), onConfirm: (date) {
      print(date);
      // Change state
      setState(() {
//        _birthday = date.toString().split(" ")[0];
      });
    });
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
        );

        setState(() {
          _imageFile = pickedFile;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }
  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }


  is_company company = is_company.Company;
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sign_up_title".tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text("create_account".tr(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            SizedBox(height: 20),

            /// Profile photo
            GestureDetector(
              child: _imageFile == null ? CircleAvatar(
                backgroundColor: kColorPrimary,
                radius: 50,
                child: SvgIcon("assets/icons/camera_icon.svg",
                    width: 40, height: 40, color: Colors.white),
              ) :
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 50,
                backgroundImage: Image.file(File(_imageFile.path), fit: BoxFit.cover,).image,
                ),
              onTap: () {
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
            ),
            SizedBox(height: 10),

            SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: is_company.Company,
                  groupValue: company,
                  activeColor: Colors.grey,
                  onChanged: (is_company value) {
                    setState(() {
                      company = value;
                    });
                  },
                ),
                Text('Работадатель', style: TextStyle(color: Colors.black)),
                Radio(
                  value: is_company.User,
                  groupValue: company,
                  activeColor: Colors.grey,
                  onChanged: (is_company value) {
                    setState(() {
                      company = value;
                    });
                  },
                ),
                Text('Работник', style: TextStyle(color: Colors.black))
              ],
            ),
            /// Form
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  /// Fullname field
                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('username'.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),)),
                  TextFormField(
                    controller: _username_controller,
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
                      child: Text('password'.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),)),
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
                      child: Text('password_confirm'.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),)),
                  TextFormField(
                    controller: _password_confirm_controller,
                    obscureText: _obscureText,
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
                    validator: (name) {
                      // Basic validation
                      if (name.isEmpty) {
                        return "please_fill_this_field".tr();
                      }
                      else if(_password_confirm_controller.text != _password_controller.text) {
                        return "passwords_dont_satisfy".tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('name'.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),)),
                  TextFormField(
                    controller: _name_controller,
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
                      child: Text('surname'.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),)),
                  TextFormField(
                    controller: _surnname_controller,
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
                      child: Text('email'.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),)),
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
                      child: Text('phone_number'.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),)),
                  TextFormField(
                    controller: _phone_number_controller,
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
                      child: Text('linked_link'.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),)),
                  TextFormField(
                    controller: _linked_link_controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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

                  /// Sign Up button
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      padding: EdgeInsets.all(15),
                      color: kColorPrimary,
                      textColor: Colors.white,
                      onPressed: () {
                        /// Validate form
//                         if (_formKey.currentState.validate()) {
//                           Navigator.of(context)
//                               .popUntil((route) => route.isFirst);
//
//                           User user = new User();
//                           user.username = _username_controller.text;
//                           user.password = _password_controller.text;
//                           user.email = _email_controller.text;
//                           user.phone_number = _phone_number_controller.text;
//                           user.linked_link = _linked_link_controller.text;
//                           user.name = _name_controller.text;
//                           user.surname = _surnname_controller.text;
//
//                           if(_imageFile != null)
//                             user.uploadImage1(File(_imageFile.path));
//                           else
//                             user.uploadImage1(null);
//
//                           Navigator.pushReplacementNamed(context, Routes.home);
//                         }
//                         else{
//                           return;
//                         }
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.of(context)
                            .pushNamed(Routes.home);

                        /// Remove previous screens
                      },
                      text: 'create'.tr(),
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
