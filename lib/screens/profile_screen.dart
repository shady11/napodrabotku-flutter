import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:ishapp/datas/RSAA.dart';
import 'package:ishapp/datas/app_state.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/constants/configs.dart';
import 'package:ishapp/widgets/basic_user_info.dart';
import 'package:ishapp/widgets/user_course_info.dart';
import 'package:ishapp/widgets/user_education_info.dart';
import 'package:ishapp/widgets/user_experience_info.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'chat_screen.dart';

class ProfileScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    User user = StoreProvider.of<AppState>(context).state.user.user.data;
    UserCv user_cv = StoreProvider.of<AppState>(context).state.user.user_cv.data;
        return Scaffold(
//          backgroundColor: kColorPrimary,
          appBar: AppBar(
            title: Text("profile".tr()),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor: kColorPrimary,
                      radius: 60,
                      backgroundImage: Prefs.getString(Prefs.TOKEN) != null ? NetworkImage(
                          SERVER_IP+ Prefs.getString(Prefs.PROFILEIMAGE),headers: {"Authorization": Prefs.getString(Prefs.TOKEN)}) : null,
                    ),
                  ),
                ),
                /// Profile details
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Full Name
                          Expanded(
                            child: Text(
                              '${user.name} ${user.surname}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5,),
                      user.email!=null?Container(
                        height: MediaQuery.of(context).size.height*0.05,
                        child: Text(
                          '${user.email}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ):Container(),
                      SizedBox(height: 5,),
                      user.phone_number!=null?Container(
                        height: MediaQuery.of(context).size.height*0.05,
                        child: Text(
                          '${user.phone_number}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ):Container(),
                      Divider(),*/

                      /// Profile bio
                      Center(
                        child: Text('cv'.tr(),
                            style: TextStyle(
                                fontSize: 25,
                                color: kColorDarkBlue)),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Text('basic_info'.tr(),
                            style: TextStyle(
                                fontSize: 20,
                                color: kColorDarkBlue)),
                      ),
                      BasicUserCvInfo(user_cv: user_cv, user: user,),
                      SizedBox(height: 10,),
                      Center(
                        child: Text('user_education_info'.tr(),
                            style: TextStyle(
                                fontSize: 20,
                                color: kColorDarkBlue)),
                      ),
                      (user_cv.user_educations.length>0)?UserEducationInfo(user_educations: user_cv.user_educations,):Container(
                        child: Center(child: Text("empty".tr())),
                        ),
                      SizedBox(height: 10,),
                      Center(
                        child: Text('user_experience_info'.tr(),
                            style: TextStyle(
                                fontSize: 20,
                                color: kColorDarkBlue)),
                      ),
                      user_cv.user_experiences.length>0?UserExperienceInfo(user_experiences: user_cv.user_experiences,):Container(
                        child: Center(child: Text("empty".tr())),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Text('user_course_info'.tr(),
                            style: TextStyle(
                                fontSize: 20,
                                color: kColorDarkBlue)),
                      ),
                      user_cv.user_courses.length>0?UserCourseInfo(user_courses: user_cv.user_courses,):Container(
                        child: Center(child: Text("empty".tr())),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }

  Widget _rowProfileInfo(BuildContext context,
      {@required Widget icon, @required String title}) {
    return Row(
      children: [
        icon,
        SizedBox(width: 5),
        Text(title),
      ],
    );
  }
}

