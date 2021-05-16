import 'dart:io';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ishtapp/components/custom_button.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:path/path.dart';

import 'package:ishtapp/constants/configs.dart';
import 'package:ishtapp/datas/app_state.dart';
import 'package:ishtapp/datas/pref_manager.dart';
import 'package:ishtapp/datas/user.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:gx_file_picker/gx_file_picker.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Variables
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final title_controller = TextEditingController();
  final experience_year_controller = TextEditingController();
  UserCv user_cv;
  User user;

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;
  String _retrieveDataError;
  File attachment;

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  final _name_controller = TextEditingController();
  final _surnname_controller = TextEditingController();
  final _email_controller = TextEditingController();
  final _phone_number_controller = TextEditingController();
  final _birth_date_controller = TextEditingController();
  final _linkedin_controller = TextEditingController();

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
                        _onImageButtonPressed(ImageSource.gallery,
                            context: context);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('camera'.tr()),
                    onTap: () {
                      _onImageButtonPressed(ImageSource.camera,
                          context: context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

//  List<UserExperienceForm> user_experience_forms = [];

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

  void _showDataPicker(context) {
    DatePicker.showDatePicker(context,
        locale: LocaleType.ru,
        theme: DatePickerTheme(
          headerColor: Theme.of(context).primaryColor,
          cancelStyle: const TextStyle(color: Colors.white, fontSize: 17),
          doneStyle: const TextStyle(color: Colors.white, fontSize: 17),
        ), onConfirm: (date) {
      print(date);
      // Change state
      setState(() {
        _birth_date_controller.text = date.toString().split(" ")[0];
        StoreProvider.of<AppState>(context).state.user.user.data.birth_date =
            date;
      });
    });
  }

  int count = 1;

  void _pickAttachment() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (file != null) {
      setState(() {
        attachment = file;
      });
    } else {
      // User canceled the picker
    }
  }

  bool is_migrant = false;

  @override
  Widget build(BuildContext context) {
    if (count == 1) {
      user = StoreProvider.of<AppState>(context).state.user.user.data;

      if (Prefs.getString(Prefs.USER_TYPE) == 'USER') {
        user_cv = StoreProvider.of<AppState>(context).state.user.user_cv.data;
        title_controller.text = user_cv.job_title;
        experience_year_controller.text = user_cv.experience_year == null
            ? '0'
            : user_cv.experience_year.toString();
      }
      _name_controller.text = user.name;
      _surnname_controller.text = user.surname;
      _email_controller.text = user.email;
      _phone_number_controller.text = user.phone_number;
      _linkedin_controller.text = user.linkedin;
      is_migrant = user.is_migrant == 1;

      if (user.birth_date != null)
        _birth_date_controller.text = formatter.format(user.birth_date);
      count = 2;
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("edit_profile".tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile photo
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    child: _imageFile == null
                        ? CircleAvatar(
                            backgroundColor: kColorPrimary,
                            radius: 60,
                            backgroundImage:
                                Prefs.getString(Prefs.PROFILEIMAGE) != null
                                    ? NetworkImage(
                                        SERVER_IP +
                                            Prefs.getString(Prefs.PROFILEIMAGE),
                                        headers: {
                                            "Authorization":
                                                Prefs.getString(Prefs.TOKEN)
                                          })
                                    : null,
                          )
                        : CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 50,
                            backgroundImage: Image.file(
                              File(_imageFile.path),
                              fit: BoxFit.cover,
                            ).image,
                          ),
                    onTap: () {
                      _showPicker(context);
                    },
                  ),
                  SizedBox(height: 10),
                  Text("profile_photo".tr(), textAlign: TextAlign.center),
                ],
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Prefs.getString(Prefs.USER_TYPE) == "COMPANY"
                      ? Align(
//                      widthFactor: 10,
                          heightFactor: 1.5,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'company_name'.tr(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ))
                      : Container(),
                  Prefs.getString(Prefs.USER_TYPE) == "COMPANY"
                      ? TextFormField(
                          controller: _name_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
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
                        )
                      : Container(),
//                  SizedBox(height: 20),
                  Prefs.getString(Prefs.USER_TYPE) == "USER"
                      ? Align(
                          widthFactor: 10,
                          heightFactor: 1.5,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'surname'.tr(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ))
                      : Container(),
                  Prefs.getString(Prefs.USER_TYPE) == "USER"
                      ? TextFormField(
                          controller: _name_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
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
                        )
                      : Container(),
                  SizedBox(height: 20),
                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text(
                        'email'.tr(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )),
                  TextFormField(
                    controller: _email_controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (name) {
                      // Basic validation
//                      if (name.isEmpty) {
//                        return "please_fill_this_field".tr();
//                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text(
                        'phone_number'.tr(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )),
                  TextFormField(
                    controller: _phone_number_controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (name) {
                      // Basic validation
//                      if (name.isEmpty) {
//                        return "please_fill_this_field".tr();
//                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Prefs.getString(Prefs.USER_TYPE) == "USER"
                      ? Align(
                          widthFactor: 10,
                          heightFactor: 1.5,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'birth_date'.tr(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ))
                      : Container(),
                  Prefs.getString(Prefs.USER_TYPE) == "USER"
                      ? CustomButton(
                          mainAxisAlignment: MainAxisAlignment.start,
                          width: MediaQuery.of(context).size.width * 1,
                          height: 60.0,
                          color: Colors.grey[200],
                          textColor: kColorPrimary,
                          textSize: 16,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.right,
                          text: _birth_date_controller.text,
                          onPressed: () {
                            _showDataPicker(context);
                          })
                      : Container(),
                  SizedBox(height: 20),
                  Prefs.getString(Prefs.USER_TYPE) == 'USER'
                      ? Column(
                          children: [
                            Align(
                                widthFactor: 10,
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'resume_title'.tr(),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )),
                            TextFormField(
                              controller: title_controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                                child: Text(
                                  'experience_year'.tr(),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )),
                            TextFormField(
                              controller: experience_year_controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                              child: Text(
                                'linkedin_profile'.tr(),
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            TextFormField(
                              controller: _linkedin_controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                              validator: (name) {
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            CheckboxListTile(
                              title: Text(
                                'are_you_migrant'.tr(),
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              value: is_migrant,
                              onChanged: (value) {
                                setState(() {
                                  is_migrant = value;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                          ],
                        )
                      : Container(),
                  SizedBox(height: 30),
                  user_cv == null
                      ? Container()
                      : Align(
                          widthFactor: 10,
                          heightFactor: 1.5,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'attachment'.tr(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )),
                  user_cv == null
                      ? Container()
                      : CustomButton(
                          text: attachment != null
                              ? basename(attachment.path)
                              : 'upload_new_file'.tr(),
                          width: MediaQuery.of(context).size.width * 1,
                          color: Colors.grey[200],
                          textColor: kColorPrimary,
                          onPressed: () {
                            _pickAttachment();
                          }),
                  user_cv == null ? Container() : SizedBox(height: 30),

                  /// Sign Up button
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      padding: EdgeInsets.all(15),
                      color: kColorPrimary,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          user.email = _email_controller.text;
                          user.phone_number = _phone_number_controller.text;
                          user.birth_date =
                              formatter.parse(_birth_date_controller.text);
                          user.linkedin = _linkedin_controller.text;

                          user.name = _name_controller.text;
                          user.surname = _surnname_controller.text;
                          user.is_migrant = is_migrant ? 1 : 0;

                          if (_imageFile != null)
                            user.uploadImage2(File(_imageFile.path));
                          else
                            user.uploadImage2(null);

                          if (Prefs.getString(Prefs.USER_TYPE) == 'USER') {
                            user_cv.experience_year =
                                int.parse(experience_year_controller.text);
                            user_cv.job_title = title_controller.text;

                            if (attachment != null)
                              user_cv.save(attachment: attachment);
                            else
                              user_cv.save();
                          }

                          Navigator.of(context).pop();
                        } else {
                          return;
                        }

                        /// Remove previous screens
                      },
                      text: 'save'.tr(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.check),
        onPressed: () {
          /// Save changes and go to profile screen
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ProfileScreen(
//              user: currentUserDemo
            )));
        },
      ),*/
    );
  }
}
