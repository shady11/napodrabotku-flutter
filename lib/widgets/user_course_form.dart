import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ishapp/components/custom_button.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ishapp/datas/user.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/datas/app_state.dart';

typedef OnDelete();

class UserCourseForm extends StatefulWidget {
  final UserCourse course;
  final state = _UserCourseFormState();
  final OnDelete onDelete;
  int index;

  UserCourseForm({Key key, this.course, this.onDelete, this.index}):super(key: key);

  bool isValid()=>state.validate();

  @override
  _UserCourseFormState createState() => state;
}

class _UserCourseFormState extends State<UserCourseForm> {

  final form = GlobalKey<FormState>();

  final name_controller = TextEditingController();
  final organization_name_controller = TextEditingController();
  final duration_controller = TextEditingController();
  final end_year_controller = TextEditingController();

  bool validate(){
    var valid = form.currentState.validate();
    if(valid) form.currentState.save();
    return valid;
  }
  @override
  void initState() {
//    if(StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses.length>widget.index){
//      UserCourse userExperience = new UserCourse();
//      StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses.add(userExperience);
//    }
    if(widget.course != null){
//      job_title_controller.text = StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses[widget.index].job_title;
//      start_date_controller.text = formatter.format(StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses[widget.index].start_date);
//      end_date_controller.text = formatter.format(StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses[widget.index].end_date);
//      organization_name_controller.text = StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses[widget.index].organization_name;
//      description_controller.text = StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses[widget.index].description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 0.6,
        borderOnForeground: true,
        color: Colors.white,
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                leading: Container(),
                title: Text("course".tr()),
                actions: [
                  IconButton(icon: Icon(Icons.delete), onPressed: (){
                    widget.onDelete();
                  })
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
                    StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses[widget.index].name = value;
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
                    StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses[widget.index].organization_name = value;
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
                    StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses[widget.index].duration = value;
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
                  controller: end_year_controller,
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
                    StoreProvider.of<AppState>(context).state.user.user_cv.data.user_courses[widget.index].end_year = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
