import 'dart:io';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:intl/intl.dart';

import 'package:ishapp/widgets/default_button.dart';
import 'package:ishapp/widgets/show_scaffold_msg.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/components/custom_button.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:masked_text/masked_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:ishapp/constants/configs.dart';

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
  final _phone_number_controller = TextEditingController(text: '+(996)');
  final _password_controller = TextEditingController();
  final _password_confirm_controller = TextEditingController();
  final _birth_date_controller = TextEditingController();
  bool _obscureText = true;

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;
  String _retrieveDataError;
  String _birth_date;
  bool isValid=false;
  bool isUserExists=false;

  void _showDataPicker(context) {
    var date = DateTime.now();
    DatePicker.showDatePicker(context,
        maxTime: new DateTime(date.year-13, date.month, date.day),
        locale: Prefs.getString(Prefs.LANGUAGE)=='ky'? LocaleType.ky:LocaleType.ru,
        theme: DatePickerTheme(
          headerColor: kColorPrimary,
          cancelStyle: const TextStyle(color: Colors.white, fontSize: 17),
          doneStyle: const TextStyle(color: Colors.white, fontSize: 17),
        ), onConfirm: (date) {
      print(date);
      // Change state
      setState(() {
        _birth_date_controller.text = date.toString().split(" ")[0];
      });
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
              child: Text('continue'.tr()),
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.pushReplacementNamed(
                    context, Routes.home);
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
                height: 50,
                width: 50,
                child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(kColorPrimary),)
            ),
          ),
        );
      },
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('from_gallery'.tr()),
                      onTap: () {
                        _onImageButtonPressed(ImageSource.gallery, context: context);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('camera'.tr()),
                    onTap: () {
                      _onImageButtonPressed(ImageSource.camera, context: context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
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


  is_company company = is_company.User;
  bool is_sending=false;
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
                _showPicker(context);
              },
            ),
            SizedBox(height: 10),

            SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                Text('employee'.tr(), style: TextStyle(color: Colors.black)),
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
                Text('employer'.tr(), style: TextStyle(color: Colors.black)),
              ],
            ),
            /// Form
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                 /* /// Fullname field
                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('username'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
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
                  ),*/
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
                      isValid = EmailValidator.validate(_email_controller.text);
                    },
                    validator: (name) {
                      if (name.isEmpty) {
                        return "please_fill_this_field".tr();
                      }
                      else if(!isValid){
                        return "please_write_valid_email".tr();
                      }
                      else if(isUserExists){
                        return "this_email_already_registered".tr();
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
                      child: Text('password_confirm'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
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
                  company==is_company.Company?Align(
//                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text(company==is_company.Company?'organization_name'.tr() :'name'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)):Container(),
                  company==is_company.Company?TextFormField(
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
                  ):Container(),
                  SizedBox(height: 20),
                  company==is_company.Company?Container():Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('surname_name'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                  company==is_company.Company?Container():TextFormField(
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
                      if (name.isEmpty && company==is_company.User) {
                        return "please_fill_this_field".tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('phone_number'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                  MaskedTextField
                    (
                    maskedTextFieldController: _phone_number_controller,
                    mask: "+(996)xxx xx xx xx",
                    maxLength: 18,
                    keyboardType: TextInputType.number,
                    inputDecoration: InputDecoration(
                      hintText: '+(996)',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 20),
                  company==is_company.Company?Container():Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('birth_date'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                  company==is_company.Company?Container():CustomButton(
                    width: MediaQuery.of(context).size.width * 1,
                      color: Colors.grey[200],
                      textColor: kColorPrimary,
                      text: _birth_date_controller.text,
                      onPressed: (){_showDataPicker(context);}),
                  SizedBox(height: 20),

                  /// Sign Up button
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      padding: EdgeInsets.all(15),
                      color: kColorPrimary,
                      textColor: Colors.white,
                      onPressed: () async {
                        User.checkUsername(_email_controller.text).then((
                            value) {
                          setState(() {
                            isUserExists = value;
                          });
                        });
                        _openLoadingDialog(context);

                        /// Validate form
                        if (_formKey.currentState.validate()) {
//                           Navigator.of(context)
//                               .popUntil((route) => route.isFirst);
                          final DateFormat formatter = DateFormat('yyyy-MM-dd');

                          User user = new User();
                          user.password = _password_controller.text;
                          user.email = _email_controller.text;
                          user.phone_number = _phone_number_controller.text;
                          user.birth_date =
                              formatter.parse(_birth_date_controller.text);
                          user.name = _name_controller.text;
                          user.surname = _surnname_controller.text;
                          user.is_company = company == is_company.Company;

                          var uri = Uri.parse(API_IP + API_REGISTER1);

                          // create multipart request
                          var request = new http.MultipartRequest("POST", uri);

                          // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request
                          request.fields["id"] = user.id.toString();
                          request.fields["password"] = user.password;
                          request.fields["name"] = user.name;
                          request.fields["lastname"] = user.surname;
                          request.fields["email"] = user.email;
                          request.fields["birth_date"] =
                              formatter.format(user.birth_date);
                          request.fields["active"] = '1';
                          request.fields["phone_number"] = user.phone_number;
                          request.fields["type"] =
                          user.is_company ? 'COMPANY' : 'USER';

                          // open a byteStream
                          if (_imageFile != null) {
                            var _image = File(_imageFile.path);
                            var stream =
                            new http.ByteStream(DelegatingStream.typed(_image
                                .openRead()));
                            // get file length
                            var length = await _image.length();
                            // multipart that takes file.. here this "image_file" is a key of the API request
                            var multipartFile = new http.MultipartFile(
                                'avatar', stream, length,
                                filename: basename(_image.path));
                            // add file to multipart
                            request.files.add(multipartFile);
                          }
                          request.send().then((response) {
                            print(response);
                            response.stream.transform(utf8.decoder).listen((
                                value) {
                              print(value);
                              var response = json.decode(value);
                              if (response['status'] == 200) {
                                Prefs.setString(Prefs.PASSWORD, user.password);
                                Prefs.setString(Prefs.TOKEN, response["token"]);
                                Prefs.setString(Prefs.EMAIL, response["email"]);
                                Prefs.setInt(Prefs.USER_ID, response["id"]);
                                Prefs.setString(
                                    Prefs.PROFILEIMAGE, response["avatar"]);
                                _showDialog(
                                    context, 'successfull_sign_up'.tr());
                              }
                              else {
                                _showDialog(context,
                                    'some_errors_occured_plese_try_again'.tr());
                              }
                            });
                          }).catchError((e) {
                            print(e);
                          });
                         }
                         else{
                           return;
                         }
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
