import 'dart:io';

//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ishapp/components/custom_button.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:path/path.dart';
import 'package:ishapp/datas/RSAA.dart';

import 'package:ishapp/constants/configs.dart';
import 'package:ishapp/datas/app_state.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:ishapp/screens/profile_screen.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/show_scaffold_msg.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/widgets/user_experience_form.dart';
import 'package:gx_file_picker/gx_file_picker.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Variables
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final title_controller1 = TextEditingController();
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

//  void onDelete(int index){
//    setState(() {
//      user_cv.user_experiences.removeAt(index);
//    });
//  }
//
//  void onAddForm(){
//    setState(() {
//      user_cv.user_experiences.add(UserExperience());
//    });
//  }
//
//  void onSave(){
//    user_experience_forms.forEach((form) => form.isValid());
//  }

  /*Widget buildList(var experiences){
    for(var i=0;i<experiences.length;i++){
      return UserExperienceForm(experience: experiences[i], onDelete: ()=>onDelete(i),);
    }
  }*/

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
            StoreProvider
                .of<AppState>(context)
                .state
                .user
                .user
                .data
                .birth_date = date;
          });
        });
  }

//  @override
//  void initState() {
//
//    super.initState();
//  }
  int count =1;

  void _pickAttachment() async {
    File file = await FilePicker.getFile(type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],);

    if(file != null) {
      setState(() {
        attachment = file;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    if(count ==1){
      user = StoreProvider.of<AppState>(context).state.user.user.data;
//    setState(() {

      //    });

      if(Prefs.getString(Prefs.USER_TYPE) == 'USER'){
        user_cv = StoreProvider.of<AppState>(context).state.user.user_cv.data;
        title_controller1.text = user_cv.job_title;
        experience_year_controller.text = user_cv.experience_year==null?'0':user_cv.experience_year.toString();
      }
      _name_controller.text = user.name;
      _surnname_controller.text = user.surname;
      _email_controller.text = user.email;
      _phone_number_controller.text = user.phone_number;
      if(user.birth_date!=null)
        _birth_date_controller.text = formatter.format(user.birth_date);
      count =2;
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
                    child: _imageFile == null ? CircleAvatar(
                      backgroundColor: kColorPrimary,
                      radius: 60,
                      backgroundImage: Prefs.getString(Prefs.PROFILEIMAGE) != null ? NetworkImage(
                          SERVER_IP+ Prefs.getString(Prefs.PROFILEIMAGE),headers: {"Authorization": Prefs.getString(Prefs.TOKEN)}) : null,
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
                  Prefs.getString(Prefs.USER_TYPE)=="COMPANY"?Align(
//                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('company_name'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)):Container(),
                  Prefs.getString(Prefs.USER_TYPE)=="COMPANY"?TextFormField(
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
//                  SizedBox(height: 20),
                  Prefs.getString(Prefs.USER_TYPE)=="USER"?Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('surname'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)):Container(),
                  Prefs.getString(Prefs.USER_TYPE)=="USER"?TextFormField(
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
                  ):Container(),
                  SizedBox(height: 20),
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
                      child: Text('phone_number'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
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
//                      if (name.isEmpty) {
//                        return "please_fill_this_field".tr();
//                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Prefs.getString(Prefs.USER_TYPE)=="USER"?Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('birth_date'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)):Container(),
                  Prefs.getString(Prefs.USER_TYPE)=="USER"?CustomButton(
                      mainAxisAlignment: MainAxisAlignment.start,
                      width: MediaQuery.of(context).size.width * 1,
                      height: 60.0,
                      color: Colors.grey[200],
                      textColor: kColorPrimary,
                      textSize: 16,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.right,
                      text: _birth_date_controller.text,
                      onPressed: (){_showDataPicker(context);}):Container(),
                  SizedBox(height: 20),
                  Prefs.getString(Prefs.USER_TYPE) == 'USER'?Column(children: [
//                    AppBar(
//                      leading: Container(),
//                      title: Text("cv".tr()),
//                    ),
//                    SizedBox(height: 20),
                    Align(
//                      widthFactor: 10,
                        heightFactor: 1.5,
                        alignment: Alignment.topLeft,
                        child: Text('resume_title'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                    TextFormField(
                      controller: title_controller1,
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
                        child: Text('experience_year'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                    TextFormField(
                      controller: experience_year_controller,
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
                  ],):Container(),
                  SizedBox(height: 30),
                  user_cv== null?Container():Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('attachment'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                  user_cv== null?Container():CustomButton(text: attachment != null?basename(attachment.path):'upload_new_file'.tr(), width: MediaQuery.of(context).size.width*1, color: Colors.grey[200], textColor: kColorPrimary, onPressed: (){
                    _pickAttachment();
                  }),
                  user_cv== null?Container():SizedBox(height: 30),
                  /// Sign Up button
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      padding: EdgeInsets.all(15),
                      color: kColorPrimary,
                      textColor: Colors.white,
                      onPressed: () {
//                        onSave();
                        /// Validate form
                        if (_formKey.currentState.validate()) {
                          final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          user.email = _email_controller.text;
                          user.phone_number = _phone_number_controller.text;
                          user.birth_date = formatter.parse(_birth_date_controller.text);
                          user.name = _name_controller.text;
                          user.surname = _surnname_controller.text;

                          if(_imageFile != null)
                            user.uploadImage2(File(_imageFile.path));
                          else
                            user.uploadImage2(null);

                          if(Prefs.getString(Prefs.USER_TYPE) == 'USER'){
                            user_cv.experience_year = int.parse(experience_year_controller.text);
                            user_cv.job_title = title_controller1.text;

                            if(attachment!=null)
                              user_cv.save(attachment: attachment);
                            else
                              user_cv.save();
                          }

                          Navigator.of(context).pop();
                          // StoreProvider.of<AppState>(context).dispatch(getUser())
                          // Navigator.of(context).popAndPushNamed(Routes.user_details);
                        }
                        else{
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
