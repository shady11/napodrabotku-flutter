import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:ishapp/components/custom_button.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:ishapp/screens/edit_profile_screen.dart';
import 'package:ishapp/screens/profile_likes_screen.dart';
import 'package:ishapp/screens/profile_screen.dart';
import 'package:ishapp/screens/profile_visits_screen.dart';
import 'package:ishapp/tabs/kk.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/app_section_card.dart';
import 'package:ishapp/widgets/badge.dart';
import 'package:ishapp/widgets/profile_basic_info_card.dart';
import 'package:ishapp/widgets/profile_statistics_card.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/constants/configs.dart';

class ProfileTab extends StatelessWidget {
 
  // Variables
  final _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Basic profile info
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Profile image
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 60,
                      backgroundImage: NetworkImage(
                          API_IP+ API_GET_PROFILE_IMAGE,headers: {"Authorization": Prefs.getString(Prefs.TOKEN)}),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    "UlutSoft",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    /// Profile details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),

                        /// Location
                        Row(
                          children: [
                            SvgIcon("assets/icons/location_point_icon.svg",
                                color: Colors.white),
                            SizedBox(width: 5),
                            Text("Бишкек ул. Чехова 28",
                                style: TextStyle(color: Colors.white))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),

                /// Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: CustomButton(
                        height: 50.0,
                        padding: EdgeInsets.all(10),
                        color: kColorPrimary,
                        textColor: Colors.white,
                        onPressed: () {
//                          Navigator.of(context).pop();
                        },
                        text: 'view'.tr(),
                      ),
                    ),
                    SizedBox(
                      child: CustomButton(
                        height: 50.0,
                        padding: EdgeInsets.all(10),
                        color: Color(0xffF2F2F5),
                        textColor: kColorPrimary,
                        onPressed: () {
//                          Navigator.of(context).pop();
                        },
                        text: 'edit'.tr(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          /// Profile Statistics Card
          Column(
            children: [
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  child: Icon(Boxicons.bx_like, size: 25, color: kColorPrimary,),
                  decoration: BoxDecoration(
                      color: Color(0xffF2F2F5),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                title: Text("likeds".tr(), style: _textStyle),
                trailing: Text('22', style: TextStyle(color: Colors.grey[400]),),
                onTap: () {
                  /// Go to profile likes screen ()
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfileLikesScreen()));
                },
              ),
              ListTile(
                leading: Icon(Boxicons.bx_file, size: 25, color: kColorPrimary,),
                title: Text("visit".tr(), style: _textStyle),
                trailing: Text('15', style: TextStyle(color: Colors.grey[400]),),
                onTap: () {
                  /// Go to profile visits screen
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfileVisitsScreen()));
                },
              ),
              /*ListTile(
            leading: SvgIcon("assets/icons/close_icon.svg",
                width: 25, height: 25, color: Theme.of(context).primaryColor),
            title: Text("DISLIKED PROFILES", style: _textStyle),
            trailing: Badge(text: "325"),
            onTap: () {
              /// Go to disliked profile screen
              Navigator.push(context, MaterialPageRoute(
                 builder: (context) => DislikedProfilesScreen()));
            },
          ),*/
            ],
          ),
          SizedBox(height: 20),
          /// App Section Card
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text("language".tr(), style: _textStyle),
                onTap: () {
                  Navigator.pushNamed(context, Routes.change_language);
                },
              ),
              ListTile(
                title: Text("about_us".tr(), style: _textStyle),
                onTap: () {
                  /// Go to About us

                },
              ),
              ListTile(
                title: Text("share_with_friends".tr(), style: _textStyle),
                onTap: () {
                  /// Share app
                },
              ),
              Divider(height: 0),
              ListTile(
                title: Text("privacy_policy".tr(), style: _textStyle),
                onTap: () async {
                  /// Go to privacy policy
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
