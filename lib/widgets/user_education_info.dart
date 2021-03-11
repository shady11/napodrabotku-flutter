import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/datas/user.dart';

class UserEducationInfo extends StatelessWidget {
  List<UserEducation> user_educations;

  UserEducationInfo({this.user_educations});

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Widget buildList(){
    for(var i in user_educations){
      return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("title".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text(i.title,softWrap: true,
                    style: TextStyle(fontSize: 22,)),
              ],
            ),
            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("faculty".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Flexible(
                  child: Text(i.faculty,softWrap: true,
                      style: TextStyle(fontSize: 22,)),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("speciality".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Flexible(
                  child: Text(i.speciality,softWrap: true,
                      style: TextStyle(fontSize: 22,)),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("type".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Flexible(
                  child: Text(i.type,softWrap: true,
                      style: TextStyle(fontSize: 22,)),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("end_year".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text(i.end_year.toString() ,softWrap: true,
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
//      height: MediaQuery.of(context).size.height*0.4,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
      child: Column(
        children: [buildList()],
      )
    );
  }
}
