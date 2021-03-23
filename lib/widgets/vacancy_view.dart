import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ishapp/datas/RSAA.dart';
import 'package:ishapp/datas/app_state.dart';
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
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/constants/configs.dart';

class VacancyView extends StatelessWidget {
  /// User object
  final Vacancy vacancy;
  /// Screen to be checked
  final String page;
  /// Swiper position
  final SwiperPosition position;

  VacancyView({this.page, this.position, @required this.vacancy});

  void _showDialog(context,String message) {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        child: AlertDialog(
          title: Text(''),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('back'.tr()),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            CustomButton(text: "sign_in".tr(),
                textColor: kColorPrimary,
                color: Colors.white,
                onPressed:(){
                  Navigator.of(context)
                      .popUntil((route) => route.isFirst);
                  Navigator.pushNamed(context, Routes.start);
                })
          ],
        ),
      ),
    );
  }
  void _showDialog1(context,String message) {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        child: AlertDialog(
          title: Text(''),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('okay'.tr()),
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
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            /// User Card

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
//                          Align(
//                            alignment: Alignment.topLeft,
//                            child: ClipRRect(
//                                borderRadius: BorderRadius.circular(20),
//                                child: Image.network(API_IP+ API_GET_COMPANY_AVATAR + vacancy.id.toString(),headers: {"Authorization": Prefs.getString(Prefs.TOKEN)}, width: 80,
//                                  height: 60,)
//                            ),
//                          ),
                        SizedBox(width: 20),
                        Expanded(
                          child: RichText(
                            text: TextSpan(text: vacancy.company_name.toString() + '\n',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(text: vacancy.address, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black45)),
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
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color(0xffF2F2F5),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text(vacancy.type.toString(), style: TextStyle(color: Colors.black87),),
                        ),
                        SizedBox(width: 5,),
                        Flexible(child: Text(vacancy.salary!=null ?vacancy.salary:'', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kColorPrimary),)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color(0xffF2F2F5),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text(vacancy.schedule.toString(), style: TextStyle(color: Colors.black87),),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text('по собеседованию', style: TextStyle(color: Colors.grey[500]),),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    /// User job title
                    Text(vacancy.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                    SizedBox(height: 10),
                    page =='discover' ? Expanded(
                      child: RichText(
                        text: TextSpan(text: vacancy.description, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black45)),
                      ),
                    ) : SizedBox(),
                    SizedBox(height: 20),
                    Expanded(
                      flex:1,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: RichText(
                          text: TextSpan(text: vacancy.description, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black45)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          page =='discover' ?Container() :page=='submitted'||page=='inactive'||page=='company_view'?Container():Center(
                            child: CustomButton(
                              width: MediaQuery.of(context).size.width * 0.35,
                              padding: EdgeInsets.all(5),
                              color: kColorPrimary,
                              textColor: Colors.white,
                              onPressed: () {
                                Prefs.getString(Prefs.TOKEN )==null?_showDialog(context, 'sign_in_to_submit'.tr()):User.checkUserCv(Prefs.getInt(Prefs.USER_ID)).then((value) {
                                  if(value){
                                    Vacancy.saveVacancyUser(vacancy_id: vacancy.id, type: "SUBMITTED").then((value) {
                                      if(value=="OK"){
                                        _showDialog1(context, "successfully_submitted".tr());
                                        StoreProvider.of<AppState>(context).state.vacancy.list.data.remove(vacancy);
                                        StoreProvider.of<AppState>(context).dispatch(getSubmittedVacancies());
                                        StoreProvider.of<AppState>(context).dispatch(getNumberOfSubmittedVacancies());
                                      }
                                      else{
                                        _showDialog(context, "some_errors_occured_try_again".tr());
                                      }
                                    });
                                  }
                                  else{
                                    _showDialog(context, "please_fill_user_cv_to_submit".tr());
                                  }
                                });
                              },
                              text: 'submit'.tr(),
                            ),
                          ),
                        ],
                      ),
                    ),

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
