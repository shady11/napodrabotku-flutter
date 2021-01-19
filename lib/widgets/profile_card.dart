import 'package:flutter/material.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/widgets/show_like_or_dislike.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:swipe_stack/swipe_stack.dart';

import 'badge.dart';
import 'default_card_border.dart';

class ProfileCard extends StatelessWidget {
  /// User object
  final User user;
  /// Screen to be checked
  final String page;
  /// Swiper position
  final SwiperPosition position;

  ProfileCard({this.page, this.position, @required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Stack(
        children: [
          /// User Card
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4.0,
            margin: EdgeInsets.all(0),
            shape: defaultCardBorder(),
            child: Container(
              decoration: BoxDecoration(
                /// User profile image
                image: DecorationImage(
                    image: AssetImage(user.userPhotoLink),
                    fit: BoxFit.cover),
              ),
              child: Container(
                /// BoxDecoration to make user info visible
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).primaryColor,
                        Colors.transparent
                      ]),
                ),

                /// User info container
                child: Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// User fullname
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              user.userFullname,
                              style: TextStyle(
                                  fontSize: this.page == 'discover' ? 20 : 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      /// User education
                      Row(
                        children: [
                          SvgIcon("assets/icons/university_icon.svg",
                              color: Colors.white, width: 20, height: 20),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              user.userSchool,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),

                      /// User job title
                      Row(
                        children: [
                          SvgIcon("assets/icons/job_bag_icon.svg",
                              color: Colors.white, width: 17, height: 17),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              user.jobTitle,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      this.page == 'discover'
                          ? SizedBox(height: 70)
                          : Container(width: 0, height: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// User location distance
          Positioned(
            top: 10,
            left: this.page == 'discover' ? 8 : 5,
            child: Badge(
                icon: this.page == 'discover'
                    ? SvgIcon("assets/icons/location_point_icon.svg",
                        color: Colors.white, width: 15, height: 15)
                    : null,
                text: user.userDistance),
          ),

          /// Show Like or Dislike
          this.page == 'discover' 
          ? ShowLikeOrDislike(position: position) 
          : Container(width: 0, height: 0),

        ],
      ),
    );
  }
}
