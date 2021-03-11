import 'dart:io';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ishapp/components/custom_button.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ishapp/constants/configs.dart';
import 'package:ishapp/datas/app_state.dart';
import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:ishapp/screens/profile_screen.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/show_scaffold_msg.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/widgets/user_experience_form.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Variables
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _experienceForm = GlobalKey<FormState>();
  final _educationForm = GlobalKey<FormState>();
  final _courseForm = GlobalKey<FormState>();
  final title_controller1 = TextEditingController();
  final experience_year_controller = TextEditingController();
  UserCv user_cv;
  User user;

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;
  String _retrieveDataError;

  final _name_controller = TextEditingController();
  final _surnname_controller = TextEditingController();
  final _email_controller = TextEditingController();
  final _phone_number_controller = TextEditingController();
  final _birth_date_controller = TextEditingController();

  final job_title_controller = TextEditingController();
  final start_date_controller = TextEditingController();
  final end_date_controller = TextEditingController();
  final organization_name_controller = TextEditingController();
  final description_controller = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  final title_controller = TextEditingController();
  final faculty_controller = TextEditingController();
  final speciality_controller = TextEditingController();
  final end_year_controller = TextEditingController();

  final name_controller = TextEditingController();
  final course_organization_name_controller = TextEditingController();
  final duration_controller = TextEditingController();
  final course_end_year_controller = TextEditingController();

  List<UserExperienceForm> user_experience_forms = [];

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

  void onDelete(int index){
    setState(() {
      user_cv.user_experiences.removeAt(index);
    });
  }

  void onAddForm(){
    setState(() {
      user_cv.user_experiences.add(UserExperience(start_date: new DateTime.now(), end_date: new DateTime.now()));
    });
  }

  void onSave(){
    user_experience_forms.forEach((form) => form.isValid());
  }

  /*Widget buildList(var experiences){
    for(var i=0;i<experiences.length;i++){
      return UserExperienceForm(experience: experiences[i], onDelete: ()=>onDelete(i),);
    }
  }*/

  void _showDataPicker(int type) {
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
            if(type ==1) {
              start_date_controller.text = date.toString().split(" ")[0];
              StoreProvider
                  .of<AppState>(context)
                  .state
                  .user
                  .user_cv
                  .data
                  .user_experiences[0].start_date = date;
            }
            else if(type ==2) {
              end_date_controller.text = date.toString().split(" ")[0];
              StoreProvider
                  .of<AppState>(context)
                  .state
                  .user
                  .user_cv
                  .data
                  .user_experiences[0].end_date = date;
            }
            else {
              _birth_date_controller.text = date.toString().split(" ")[0];
              StoreProvider
                  .of<AppState>(context)
                  .state
                  .user
                  .user
                  .data
                  .birth_date = date;
            }
          });
        });
  }

//  @override
//  void initState() {
//
//    super.initState();
//  }
  int count =1;

  @override
  Widget build(BuildContext context) {
    if(count ==1){
      user = StoreProvider.of<AppState>(context).state.user.user.data;
//    setState(() {

      //    });

      user_cv = StoreProvider.of<AppState>(context).state.user.user_cv.data;
      title_controller1.text = user_cv.job_title;
      experience_year_controller.text = user_cv.experience_year.toString();
      _name_controller.text = user.name;
      _surnname_controller.text = user.surname;
      _email_controller.text = user.email;
      _phone_number_controller.text = user.phone_number;
      if(user.birth_date!=null)
        _birth_date_controller.text = formatter.format(user.birth_date);
      if(user_cv.user_experiences.isNotEmpty){
        job_title_controller.text = user_cv.user_experiences[0].job_title;
        start_date_controller.text = formatter.format(user_cv.user_experiences[0].start_date);
        end_date_controller.text = formatter.format(user_cv.user_experiences[0].end_date);
        organization_name_controller.text = user_cv.user_experiences[0].organization_name;
        description_controller.text = user_cv.user_experiences[0].description;
      }
      else{
        user_cv.user_experiences.add(new UserExperience());
      }
      if(user_cv.user_educations.isNotEmpty){
        title_controller.text = user_cv.user_educations[0].title;
        faculty_controller.text = user_cv.user_educations[0].faculty;
        speciality_controller.text = user_cv.user_educations[0].speciality;
        end_year_controller.text = user_cv.user_educations[0].end_year.toString();
      }
      else{
        user_cv.user_educations.add(new UserEducation());
      }
      if(user_cv.user_courses.isNotEmpty){
        name_controller.text = user_cv.user_courses[0].name;
        course_organization_name_controller.text = user_cv.user_courses[0].organization_name;
        duration_controller.text = user_cv.user_courses[0].duration;
        course_end_year_controller.text = user_cv.user_courses[0].end_year.toString();
      }
      else{
        user_cv.user_courses.add(new UserCourse());
      }
      count =2;
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Edit profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
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
                      backgroundImage: Prefs.getString(Prefs.TOKEN) != null ? NetworkImage(
                          SERVER_IP+ Prefs.getString(Prefs.PROFILEIMAGE),headers: {"Authorization": Prefs.getString(Prefs.TOKEN)}) : null,
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
                ],
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Align(
//                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('name'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
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
                      child: Text('surname'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
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
                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text('birth_date'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                  /*TextFormField(
                    controller: _birth_date_controller,
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
                  ),*/
                  CustomButton(
                      width: MediaQuery.of(context).size.width * 1,
                      color: Colors.grey[200],
                      textColor: kColorPrimary,
                      text: _birth_date_controller.text,
                      onPressed: (){_showDataPicker(3);}),
                  SizedBox(height: 20),
                  AppBar(
                    leading: Container(),
                    title: Text("cv".tr()),
                    actions: [
                              IconButton(icon: Icon(Icons.delete), onPressed: (){
//                                widget.onDelete();
                              })
                    ],
                  ),
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
                  CustomButton(
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: kColorPrimary,
                      textColor: Colors.grey[200],
                      text: "add_experience".tr(),
                      onPressed: onAddForm),
                  SizedBox(height: 10),
                  user_cv.user_experiences.length<=0?Container():
                  Column(
                    children: [
                      for(var i=0;i<user_cv.user_experiences.length;i++)
                        UserExperienceForm(experience: user_cv.user_experiences[i], onDelete: ()=>onDelete(i), index: i,)
                      ],
                  ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    elevation: 0.6,
                    borderOnForeground: true,
                    color: Colors.white,
                    child: Form(
                      key: _experienceForm,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppBar(
                            leading: Container(),
                            title: Text("experience".tr()),
                            actions: [
//                              IconButton(icon: Icon(Icons.delete), onPressed: (){
//                                widget.onDelete();
//                              })
                            ],
                          ),
                          SizedBox(height: 10,),
                          Align(
                              heightFactor: 1.5,
                              alignment: Alignment.topLeft,
                              child: Text('position'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: job_title_controller,
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
                              onChanged: (value){
                                StoreProvider.of<AppState>(context).state.user.user_cv.data.user_experiences[0].job_title = value;
                              },
                            ),
                          ),
                          SizedBox(height: 10,),
                          Align(
//                      widthFactor: 10,
                              heightFactor: 1.5,
                              alignment: Alignment.topLeft,
                              child: Text('start_date'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CustomButton(
                                width: MediaQuery.of(context).size.width * 1,
                                color: Colors.grey[200],
                                textColor: kColorPrimary,
                                text: start_date_controller.text,
                                onPressed: (){_showDataPicker(1);}),
                          ),
                          SizedBox(height: 10,),
                          Align(
                              heightFactor: 1.5,
                              alignment: Alignment.topLeft,
                              child: Text('end_date'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CustomButton(
                                width: MediaQuery.of(context).size.width * 1,
                                color: Colors.grey[200],
                                textColor: kColorPrimary,
                                text: end_date_controller.text,
                                onPressed: (){_showDataPicker(2);}),
                          ),
                          SizedBox(height: 10,),
                          Align(
//                      widthFactor: 10,
                              heightFactor: 1.5,
                              alignment: Alignment.topLeft,
                              child: Text('organization_name'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: organization_name_controller,
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
                              onChanged: (value){
                                StoreProvider.of<AppState>(context).state.user.user_cv.data.user_experiences[0].organization_name = value;
                              },
                            ),
                          ),
                          SizedBox(height: 10,),
                          Align(
//                      widthFactor: 10,
                              heightFactor: 1.5,
                              alignment: Alignment.topLeft,
                              child: Text('description'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: description_controller,
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
                              onChanged: (value){
                                StoreProvider.of<AppState>(context).state.user.user_cv.data.user_experiences[0].description = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      elevation: 0.6,
                      borderOnForeground: true,
                      color: Colors.white,
                      child: Form(
                        key: _educationForm,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppBar(
                              leading: Container(),
                              title: Text("education".tr()),
                              actions: [
//                                IconButton(icon: Icon(Icons.delete), onPressed: (){
//                                  widget.onDelete();
//                                })
                              ],
                            ),
                            SizedBox(height: 10,),
                            Align(
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text('university'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: title_controller,
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
                                onChanged: (value){
                                  StoreProvider.of<AppState>(context).state.user.user_cv.data.user_educations[0].title = value;
                                },
                              ),
                            ),
                            SizedBox(height: 10,),
                            Align(
//                      widthFactor: 10,
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text('faculty'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: faculty_controller,
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
                                onChanged: (value){
                                  StoreProvider.of<AppState>(context).state.user.user_cv.data.user_educations[0].faculty = value;
                                },
                              ),
                            ),
                            SizedBox(height: 10,),
                            Align(
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text('speciality'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: speciality_controller,
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
                                onChanged: (value){
                                  StoreProvider.of<AppState>(context).state.user.user_cv.data.user_educations[0].speciality = value;
                                },
                              ),
                            ),
                            SizedBox(height: 10,),
                            Align(
//                      widthFactor: 10,
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text('end_year'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: end_year_controller,
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
                                  // Basic validation
                                  if (name.isEmpty) {
                                    return "please_fill_this_field".tr();
                                  }
                                  return null;
                                },
                                onChanged: (value){
                                  StoreProvider.of<AppState>(context).state.user.user_cv.data.user_educations[0].end_year = value;
                                },
                              ),
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      elevation: 0.6,
                      borderOnForeground: true,
                      color: Colors.white,
                      child: Form(
                        key: _courseForm,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppBar(
                              leading: Container(),
                              title: Text("course".tr()),
                              actions: [
//                                IconButton(icon: Icon(Icons.delete), onPressed: (){
//                                  widget.onDelete();
//                                })
                              ],
                            ),
                            SizedBox(height: 10,),
                            Align(
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text('course_name'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: name_controller,
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
                                onChanged: (value){
                                  StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses[0].name = value;
                                },
                              ),
                            ),
                            SizedBox(height: 10,),
                            Align(
//                      widthFactor: 10,
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text('organization_name'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: course_organization_name_controller,
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
                                onChanged: (value){
                                  StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses[0].organization_name = value;
                                },
                              ),
                            ),
                            SizedBox(height: 10,),
                            Align(
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text('duration'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: duration_controller,
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
                                onChanged: (value){
                                  StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses[0].duration = value;
                                },
                              ),
                            ),
                            SizedBox(height: 10,),
                            SizedBox(height: 10,),
                            Align(
//                      widthFactor: 10,
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text('end_year'.tr(), style: TextStyle(fontSize: 16, color: Colors.black),)),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: course_end_year_controller,
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
                                  // Basic validation
                                  if (name.isEmpty) {
                                    return "please_fill_this_field".tr();
                                  }
                                  return null;
                                },
                                onChanged: (value){
                                  StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses[0].end_year = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /// Sign Up button
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      padding: EdgeInsets.all(15),
                      color: kColorPrimary,
                      textColor: Colors.white,
                      onPressed: () {
                        onSave();
                        /// Validate form
                        if (_formKey.currentState.validate()) {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
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
                          
                          user_cv.experience_year = int.parse(experience_year_controller.text);
                          user_cv.job_title = title_controller1.text;
//                          experiences
                          user_cv.user_experiences[0].job_title = job_title_controller.text;
                          user_cv.user_experiences[0].organization_name = organization_name_controller.text;
                          user_cv.user_experiences[0].start_date = formatter.parse(start_date_controller.text);
                          user_cv.user_experiences[0].end_date = formatter.parse(end_date_controller.text);
                          user_cv.user_experiences[0].description = description_controller.text;

//                          educations
                          user_cv.user_educations[0].title = title_controller.text;
                          user_cv.user_educations[0].end_year = end_year_controller.text;
                          user_cv.user_educations[0].speciality = speciality_controller.text;
                          user_cv.user_educations[0].faculty = faculty_controller.text;
                          user_cv.user_educations[0].type = "1";

//                          courses
                          user_cv.user_courses[0].name = name_controller.text;
                          user_cv.user_courses[0].organization_name = course_organization_name_controller.text;
                          user_cv.user_courses[0].duration = duration_controller.text;
                          user_cv.user_courses[0].end_year = course_end_year_controller.text;

                          user_cv.save();

                          Navigator.pushReplacementNamed(context, Routes.home);
                        }
                        else{
                          return;
                        }
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.of(context)
                            .pushNamed(Routes.home);

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
