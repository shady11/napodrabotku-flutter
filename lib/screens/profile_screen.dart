import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/widgets/badge.dart';
import 'package:ishapp/widgets/svg_icon.dart';

import 'chat_screen.dart';

class ProfileScreen extends StatelessWidget {
  /// Get user object
  final User user;

  ProfileScreen({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                /// Carousel Profile images
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Carousel(
                      autoplay: false,
                      dotBgColor: Colors.transparent,
                      dotIncreasedColor: Theme.of(context).primaryColor,
                      images: [
                        AssetImage(user.userPhotoLink),
                        AssetImage(user.userPhotoLink),
                        AssetImage(user.userPhotoLink),
                      ]),
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

                          /// Location distance
                          Badge(
                              icon: SvgIcon(
                                  "assets/icons/location_point_icon.svg",
                                  color: Colors.white,
                                  width: 15,
                                  height: 15),
                              text: "${user.userDistance} away")
                        ],
                      ),

                      SizedBox(height: 5),

                      /// Home location
                      _rowProfileInfo(context,
                          icon: SvgIcon("assets/icons/location_point_icon.svg",
                              color: Theme.of(context).primaryColor,
                              width: 24,
                              height: 24),
                          title: "New York, United States"),

                      SizedBox(height: 5),

                      /// Job title
                      _rowProfileInfo(context,
                          icon: SvgIcon("assets/icons/job_bag_icon.svg",
                              color: Theme.of(context).primaryColor,
                              width: 24,
                              height: 24),
                          title: user.jobTitle),

                      SizedBox(height: 5),

                      /// Education
                      _rowProfileInfo(context,
                          icon: SvgIcon("assets/icons/university_icon.svg",
                              color: Theme.of(context).primaryColor,
                              width: 28,
                              height: 28),
                          title: user.userSchool),

                      Divider(),

                      /// Profile bio
                      Text('Bio',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor)),
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
        backgroundColor: Theme.of(context).primaryColor,
        child: SvgIcon("assets/icons/message_icon.svg",
            color: Colors.white, width: 30, height: 30),
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
