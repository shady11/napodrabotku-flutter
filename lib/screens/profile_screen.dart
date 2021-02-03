import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/badge.dart';
import 'package:ishapp/widgets/svg_icon.dart';

import 'chat_screen.dart';

class ProfileScreen extends StatelessWidget {
  /// Get user object
  User user = currentUserDemo;

  ProfileScreen({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(user.userPhotoLink, width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.3,)
                    ),
                  ),
                ),

                /// Profile details
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Full Name
                          Expanded(
                            child: Text(
                              user.userFullname,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),

                        ],
                      ),

                      SizedBox(height: 5),

//                      /// Education
//                      _rowProfileInfo(context,
//                          icon: SvgIcon("assets/icons/university_icon.svg",
//                              color: Theme.of(context).primaryColor,
//                              width: 28,
//                              height: 28),
//                          title: user.userSchool),

                      Divider(),

                      /// Profile bio
                      Text('Bio',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black)),
                      SizedBox(height: 10,),
                      Text(DEMO_PROFILE_BIO,
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// AppBar to return back
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kColorPrimary,
        child: Icon(Boxicons.bx_message_rounded,  size: 40,),
        onPressed: () {
          /// Go to chat screen
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatScreen(user: user)));
        },
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
