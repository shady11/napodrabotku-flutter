import 'package:flutter/material.dart';
import 'package:ishapp/datas/RSAA.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/tabs/discover_tab.dart';
import 'package:ishapp/widgets/show_like_or_dislike.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ishapp/datas/app_state.dart';
import 'package:ishapp/components/custom_button.dart';
import 'package:ishapp/routes/routes.dart';
import 'badge.dart';
import 'default_card_border.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/constants/configs.dart';

class UserCard extends StatelessWidget {
  /// User object
  final User user;
  /// Screen to be checked
  final String page;
  final int index;
  /// Swiper position
  final SwiperPosition position;

  UserCard({this.page, this.position, @required this.user, this.index});

  void _showDialog(context,String message) {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        child: AlertDialog(
          title: Text(''),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'.tr()),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: index == 0 ?  MediaQuery.of(context).size.width * 1: (index == 1 ?  MediaQuery.of(context).size.width * 0.95:(index == 2 ?  MediaQuery.of(context).size.width * 0.9:(index == 3 ?  MediaQuery.of(context).size.width * 0.85:(index == 4 ?  MediaQuery.of(context).size.width * 0.8:MediaQuery.of(context).size.width * 0.75)))),
      height: MediaQuery.of(context).size.height * 0.62,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 4.0,
              color: Colors.white,
              margin: EdgeInsets.all(0),
              shape: defaultCardBorder(),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20.0),
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
                            child: user.image!=null? Image.network(SERVER_IP+ user.image,headers: {"Authorization": Prefs.getString(Prefs.TOKEN)}, width: 80,
                              height: 60,):Image.asset('assets/images/camera.png', fit: BoxFit.cover,width: 80, height: 60,),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: RichText(
                            text: TextSpan(text: user.surname.toString() + '\n',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(text: user.email, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black45)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    index==null||index <=2 ?Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color(0xffF2F2F5),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text(user.phone_number, style: TextStyle(color: Colors.black87),),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(user.vacancy_name!=null ?user.vacancy_name:'', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kColorPrimary),),
                        ),
                      ],
                    ): Container(),
                    index==null||index <=2 ?Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color(0xffF2F2F5),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text(user.experience_year.toString(), style: TextStyle(color: Colors.black87),),
                        ),
                        /*Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text('по собеседованию', style: TextStyle(color: Colors.grey[500]),),
                        ),*/
                      ],
                    ):Container(),
                    SizedBox(height: 15),
                    /// User job title
                    Text('user.name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                    SizedBox(height: 10),
                    page =='discover' ? Expanded(
                      child: RichText(
                        text: TextSpan(text: user.user_cv_name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black45)),
                      ),
                    ) : SizedBox(),
                    SizedBox(height: 20),
                    this.page == 'discover'
                        ? SizedBox(height: 0)
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
