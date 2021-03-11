import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/datas/user.dart';

class UserExperienceInfo extends StatelessWidget {
  List<UserExperience> user_experiences;

  UserExperienceInfo({this.user_experiences});

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Widget buildList(){
    for(var i in user_experiences){
      return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("title".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text(i.job_title,softWrap: true,
                    style: TextStyle(fontSize: 22,)),
              ],
            ),
            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("start_date".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text(formatter.format(i.start_date),softWrap: true,
                    style: TextStyle(fontSize: 22,)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("end_date".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text(formatter.format(i.end_date),softWrap: true,
                    style: TextStyle(fontSize: 22,)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("name".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text(i.organization_name,softWrap: true,
                    style: TextStyle(fontSize: 22,)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("description".tr(),softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text(i.description ,softWrap: true,
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
