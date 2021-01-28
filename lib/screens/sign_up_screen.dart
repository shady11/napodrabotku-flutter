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

import 'home_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sign_up".tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text("create_account".tr(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            /// Profile photo
            GestureDetector(
              child: _imageFile == null ? CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
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
            Text("profile_photo".tr(), textAlign: TextAlign.center),

            SizedBox(height: 22),

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

                  /// Birthday card
//                  Card(
//                      clipBehavior: Clip.antiAlias,
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(28),
//                          side: BorderSide(color: Colors.grey[350])),
//                      child: ListTile(
//                        leading: SvgIcon("assets/icons/calendar_icon.svg"),
//                        title: Text(_birthday,
//                            style: TextStyle(color: Colors.grey)),
//                        trailing: Icon(Icons.arrow_drop_down),
//                        onTap: () {
//                          /// Select birthday
//                          _showDataPicker();
//                        },
//                      )),
//                  SizedBox(height: 20),

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
                  TextFormField(
                    controller: _password_confirm_controller,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: "password_confirm".tr(),
                      hintText: "confirm_your_password".tr(),
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
                    onChanged: (confirm_password){
                      if(confirm_password != _password_controller.text){
                        return "passwords_dont_satisfy".tr();
                      }
                    },
                    validator: (school) {
                      if (school.isEmpty) {
                        return "please_fill_this_field".tr();
                      }
                      else if(_password_confirm_controller.text != _password_controller.text){
                        return "passwords_dont_satisfy".tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _name_controller,
                    decoration: InputDecoration(
                        labelText: "name".tr(),
                        hintText: "enter_your_name".tr(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: SvgIcon("assets/icons/name.svg"),
                        )),
                    validator: (school) {
                      if (school.isEmpty) {
                        return "please_fill_this_field".tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _surnname_controller,
                    decoration: InputDecoration(
                        labelText: "surname".tr(),
                        hintText: "enter_your_surname".tr(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: SvgIcon("assets/icons/identification.svg"),
                        )),
                    validator: (school) {
//                      if (school.isEmpty) {
//                        return "please_fill_this_field".tr();
//                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _email_controller,
                    decoration: InputDecoration(
                        labelText: "email".tr(),
                        hintText: "enter_your_email".tr(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: SvgIcon("assets/icons/email.svg"),
                        )),
                    validator: (school) {
                      if (school.isEmpty) {
                        return "please_fill_this_field".tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  /// Job title field
                  TextFormField(
                    controller: _phone_number_controller,
                    decoration: InputDecoration(
                        labelText: "phone_number".tr(),
                        hintText: "enter_your_phone_number".tr(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgIcon("assets/icons/phone-book.svg"),
                        )),
                    validator: (job) {
//                      if (job.isEmpty) {
//                        return "please_fill_this_field".tr();
//                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  /// Bio field
                  TextFormField(
                    controller: _linked_link_controller,
                    decoration: InputDecoration(
                      labelText: "linked_link".tr(),
                      hintText: "write_your_linked_link".tr(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgIcon("assets/icons/linkedin.svg"),
                      ),
                    ),
                    validator: (bio) {
//                      if (bio.isEmpty) {
//                        return "please_fill_this_field".tr();
//                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  /// Sign Up button
                  SizedBox(
                    width: double.maxFinite,
                    child: DefaultButton(
                      child: Text("sign_up".tr(), style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        /// Validate form
                         if (_formKey.currentState.validate()) {
                           Navigator.of(context)
                               .popUntil((route) => route.isFirst);

                           User user = new User();
                           user.username = _username_controller.text;
                           user.password = _password_controller.text;
                           user.email = _email_controller.text;
                           user.phone_number = _phone_number_controller.text;
                           user.linked_link = _linked_link_controller.text;
                           user.name = _name_controller.text;
                           user.surname = _surnname_controller.text;

                           if(_imageFile != null)
                             user.uploadImage1(File(_imageFile.path));
                           else
                             user.uploadImage1(null);

                           Navigator.pushReplacementNamed(context, Routes.home);
                         }
                         else{
                           return;
                         }

                        /// Remove previous screens
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
