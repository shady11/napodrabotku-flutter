import 'package:flutter/material.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/datas/vacancy.dart';
import 'package:ishapp/widgets/show_like_or_dislike.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/components/custom_button.dart';
import 'package:ishapp/routes/routes.dart';
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
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
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
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// User fullname
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(vacancy.company_logo_image, width: MediaQuery.of(context).size.width * 0.18,
                                  height: MediaQuery.of(context).size.height * 0.09,)
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: RichText(
                              text: TextSpan(text: vacancy.company_name + '\n',
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(text: 'Бишкек', style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black45)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey[500],
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text('Полная занятость', style: TextStyle(color: Colors.black87),),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Text('45000 - 70000', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kColorPrimary),),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey[500],
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text('Гибкий график', style: TextStyle(color: Colors.black87),),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text('По собеседованию', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500]),),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      /// User job title
                      Expanded(
                        child: RichText(
                          text: TextSpan(text: vacancy.name + '\n\n',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(text: 'sdfg,sd,gfposdf,o,dsfgsdfgsdfgsdfgsdfg sdfgsdfgsdf dgfsdfgsdfgsdfgs sdgfsdfgs sdgfsd fgsdg sdfgsdfgsdfg', style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black45)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                              padding: EdgeInsets.all(5),
                              color: Colors.grey[200],
                              textColor: kColorPrimary,
                              onPressed: () {
//                                Navigator.of(context).pop();
                              },
                              text: page =='discover' ? 'skip'.tr() : 'delete'.tr(),
                            ),
                            CustomButton(
                              padding: EdgeInsets.all(5),
                              color: kColorPrimary,
                              textColor: Colors.white,
                              onPressed: () {

//                                Navigator.of(context).pop();
                              },
                              text: 'submit'.tr(),
                            ),
                          ],
                        ),
                      ),

                      this.page == 'discover'
                          ? SizedBox(height: 20)
                          : Container(width: 0, height: 0),
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
