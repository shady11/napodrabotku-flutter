import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/datas/user.dart';
import 'package:ishapp/utils/constants.dart';

class BasicUserCvInfo extends StatelessWidget {
  UserCv user_cv;
  User user;

  BasicUserCvInfo({this.user_cv, this.user});

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("name".tr(),softWrap: true,
                  style: TextStyle(fontSize: 16, color: Colors.grey, height: 2)),
              Text(user.name,softWrap: true,
                  style: TextStyle(fontSize: 16, color: kColorDark)),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("surname".tr(),softWrap: true,
                  style: TextStyle(fontSize: 16, color: Colors.grey, height: 2)),
              Text(user.surname,softWrap: true,
                  style: TextStyle(fontSize: 16, color: kColorDark)),
            ],
          ),
          Divider(),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("birth_date".tr(),softWrap: true,
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              Text(formatter.format(user.birth_date),softWrap: true,
                  style: TextStyle(fontSize: 22,)),
            ],
          ),*/
          // Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("email".tr(),softWrap: true,
                  style: TextStyle(fontSize: 16, color: Colors.grey, height: 2)),
              Text(user.email,softWrap: true,
                  style: TextStyle(fontSize: 16, color: kColorDark)),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("phone_number".tr(),softWrap: true,
                  style: TextStyle(fontSize: 16, color: Colors.grey, height: 2)),
              Text(user?.phone_number,softWrap: true,
                  style: TextStyle(fontSize: 16, color: kColorDark)),
            ],
          ),
          Divider(),
          user_cv != null ?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("experience_year".tr(),softWrap: true,
                          style: TextStyle(fontSize: 16, color: Colors.grey, height: 2)),
                      Text(user_cv.experience_year.toString(),softWrap: true,
                          style: TextStyle(fontSize: 16, color: kColorDark)),
                    ],
                  ), Divider()
                ],
              ) : SizedBox()
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: [
//              Text("attachment".tr(),softWrap: true,
//                  style: TextStyle(fontSize: 20, color: Colors.grey)),
//              Text(user_cv.experience_year.toString(),softWrap: true,
//                  style: TextStyle(fontSize: 22,)),
//            ],
//          ),
//          Divider(),
        ],
      ),
    );
  }
}
