import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/datas/user.dart';

class UserCourseInfo extends StatelessWidget {
  List<UserCourse> user_courses;

  UserCourseInfo({this.user_courses});

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Widget buildList(){
    for(var i in user_courses){
      return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("name".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text(i.name,softWrap: true,
                    style: TextStyle(fontSize: 22,)),
              ],
            ),
            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("organization_name".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text(i.organization_name,softWrap: true,
                    style: TextStyle(fontSize: 22,)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("duration".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text(i.duration,softWrap: true,
                    style: TextStyle(fontSize: 22,)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("end_year".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text(i.end_year.toString(),softWrap: true,
                    style: TextStyle(fontSize: 22,)),
              ],
            ),
            Divider(),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//        height: MediaQuery.of(context).size.height*0.4,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
        child: Column(
          children: [buildList()],
        )
    );
  }
}
