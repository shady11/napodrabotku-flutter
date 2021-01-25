import 'package:flutter/material.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/datas/vacancy.dart';
import 'package:ishapp/widgets/show_like_or_dislike.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:easy_localization/easy_localization.dart';

import 'badge.dart';
import 'default_card_border.dart';
import 'package:ishapp/utils/constants.dart';

class ProfileCard extends StatelessWidget {
  /// User object
  final Vacancy vacancy;
  /// Screen to be checked
  final String page;
  /// Swiper position
  final SwiperPosition position;

  ProfileCard({this.page, this.position, @required this.vacancy});

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
//              decoration: BoxDecoration(
//                /// User profile image
//                image: DecorationImage(
//                    image: AssetImage(user.userPhotoLink),
//                    fit: BoxFit.cover),
//              ),
              child: Container(
                /// BoxDecoration to make user info visible
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [
                        Theme.of(context).primaryColor,
                        Colors.grey,
                      ]),
                ),

                /// User info container
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// User fullname
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                vacancy.company_name,
                                style: TextStyle(
                                    fontSize: this.page == 'discover' ? 20 : 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),

                      /// User education
                      Row(
                        children: [
                          SizedBox(width: 5),
                          Expanded(
                            child: Center(
                              child: Text(
                                vacancy.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 5),
                          Expanded(
                            child: Center(
                              child: Text(vacancy.experience ==null ? "without_experience".tr() :"experience".tr()+
                                vacancy.experience + "year".tr(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      /// User job title
                      Row(
                        children: [
                          SvgIcon("assets/icons/job_bag_icon.svg",
                              color: Colors.white, width: 17, height: 17),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              vacancy.description,
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
            right: MediaQuery.of(context).size.width * 0.3,
//            top: MediaQuery.of(context).size.height * 0.01,
            left: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(vacancy.company_logo_image),
                        fit: BoxFit.fill
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
