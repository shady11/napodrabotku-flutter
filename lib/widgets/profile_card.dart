import 'package:flutter/material.dart';
import 'package:ishtapp/datas/RSAA.dart';
import 'package:ishtapp/datas/user.dart';
import 'package:ishtapp/datas/vacancy.dart';
import 'package:ishtapp/tabs/discover_tab.dart';
import 'package:ishtapp/widgets/show_like_or_dislike.dart';
import 'package:ishtapp/widgets/svg_icon.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ishtapp/datas/app_state.dart';
import 'package:ishtapp/widgets/vacancy_view.dart';
import 'package:ishtapp/components/custom_button.dart';
import 'package:ishtapp/routes/routes.dart';
import 'badge.dart';
import 'default_card_border.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/datas/pref_manager.dart';
import 'package:ishtapp/constants/configs.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/screens/chat_screen.dart';
import 'package:ishtapp/datas/demo_users.dart';

class ProfileCard extends StatelessWidget {
  /// User object
  final Vacancy vacancy;
  final VacanciesScreenProps props;

  /// Screen to be checked
  final String page;
  final int index;
  int offset;

  /// Swiper position
  final SwiperPosition position;

  ProfileCard(
      {this.page,
        this.position,
        @required this.vacancy,
        this.index,
        this.offset,
        this.props});

  void _openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            content: Container(
                color: Colors.transparent,
                height: 50,
                width: 50,
                child: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(kColorPrimary),
                    ))),
          ),
        );
      },
    );
  }

  void _showDialog(context, String message) {
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
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  void _showOnDeleteDialog(context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        heightFactor: 1 / 2,
        child: AlertDialog(
          backgroundColor: kColorWhite,
          title: Text(''),
          content: Text(
            message,
            style: TextStyle(color: kColorPrimary),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'no'.tr(),
                style: TextStyle(color: kColorDark),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            FlatButton(
              child: Text(
                'yes'.tr(),
                style: TextStyle(color: kColorPrimary),
              ),
              onPressed: () {
                Vacancy.deleteCompanyVacancy(
                  vacancy_id: vacancy.id,
                ).then((value) {
                  StoreProvider.of<AppState>(context)
                      .state
                      .vacancy
                      .list
                      .data
                      .remove(vacancy);
                  // StoreProvider.of<AppState>(context).dispatch(getCompanyVacancies());
                  StoreProvider.of<AppState>(context)
                      .dispatch(getNumberOfActiveVacancies());
                  StoreProvider.of<AppState>(context)
                      .dispatch(getNumberOfInactiveVacancies());
                  Navigator.of(ctx).pop();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showOnDeactivateDialog(context, String message, bool active) {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        heightFactor: 1 / 2,
        child: AlertDialog(
          backgroundColor: kColorWhite,
          title: Text(''),
          content: Text(
            message,
            style: TextStyle(color: kColorPrimary),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'no'.tr(),
                style: TextStyle(color: kColorDark),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
//                Navigator.of(ctx).pop();
              },
            ),
            FlatButton(
              child: Text(
                'yes'.tr(),
                style: TextStyle(color: kColorPrimary),
              ),
              onPressed: () {
                Vacancy.activateDeactiveVacancy(
                    vacancy_id: vacancy.id, active: active)
                    .then((value) {
//                  StoreProvider.of<AppState>(context).dispatch(getCompanyVacancies());
                  StoreProvider.of<AppState>(context)
                      .dispatch(getNumberOfActiveVacancies());
                  StoreProvider.of<AppState>(context)
                      .dispatch(getNumberOfInactiveVacancies());
                  if (active)
                    StoreProvider.of<AppState>(context)
                        .state
                        .vacancy
                        .inactive_list
                        .data
                        .remove(vacancy);
                  else
                    StoreProvider.of<AppState>(context)
                        .state
                        .vacancy
                        .list
                        .data
                        .remove(vacancy);
//                  Navigator.of(ctx).pop();
                  Navigator.of(ctx).pop();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void removeCards({String type, int vacancy_id, props, context}) {
    print(offset);
    if (Prefs.getString(Prefs.TOKEN) != null) {
      if (type == "LIKED") {
        props.addOneToMatches();
      }
      Vacancy.saveVacancyUser(vacancy_id: vacancy_id, type: type).then((value) {
        StoreProvider.of<AppState>(context).dispatch(getNumberOfLikedVacancies());
      });
      // setState(() {
        props.listResponse.data.removeLast();
      // });
    } else {
      // StoreProvider.of<AppState>(context).dispatch(getNumberOfLikedVacancies());
      // setState(() {
        props.listResponse.data.removeLast();
      // });
    }
    Vacancy.getVacancyByOffset(
        offset: /*offset<0?0:offset*/ offset,
        job_type_ids: StoreProvider.of<AppState>(context).state.vacancy.job_type_ids,
        region_ids: StoreProvider.of<AppState>(context).state.vacancy.region_ids,
        schedule_ids: StoreProvider.of<AppState>(context).state.vacancy.schedule_ids,
        busyness_ids: StoreProvider.of<AppState>(context).state.vacancy.busyness_ids,
        vacancy_type_ids: StoreProvider.of<AppState>(context).state.vacancy.vacancy_type_ids,
        type: StoreProvider.of<AppState>(context).state.vacancy.type
    ).then((value) {
      if (value != null) {
        offset = offset + 1;
        // print(props.listResponse.data);
        // setState(() {
          props.listResponse.data.insert(0, value);
        // });
      }
    });

//    StoreProvider.of<AppState>(context).state.vacancy.list.data.last;
//    props.getVacancies();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: index == 0
          ? MediaQuery.of(context).size.width * 1
          : (index == 1
          ? MediaQuery.of(context).size.width * 0.95
          : (index == 2
          ? MediaQuery.of(context).size.width * 0.9
          : (index == 3
          ? MediaQuery.of(context).size.width * 0.85
          : (index == 4
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width * 0.75)))),
      height: MediaQuery.of(context).size.height * 0.62,
      child: Padding(
        padding: const EdgeInsets.all(15),
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
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: vacancy.company_logo != null ?
                            Image.network(
                              SERVER_IP + vacancy.company_logo,
                              headers: { "Authorization": Prefs.getString(Prefs.TOKEN) },
                              width: 70,
                              height: 70,
                            ) :
                            Image.asset(
                              'assets/images/default-user.jpg',
                              fit: BoxFit.cover,
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: vacancy.company_name.toString() + '\n',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: vacancy.region,
                                    style: TextStyle(
                                        fontFamily: 'GTEestiProDisplay',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black45
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    index == null || index <= 2 ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color(0xffF2F2F5),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            vacancy.type.toString(),
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                            child: Text(
                              vacancy.salary != null ? vacancy.salary : '',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: kColorPrimary),
                            )),
                      ],
                    ) :
                    Container(),
                    SizedBox(height: 5),
                    index == null || index <= 2 ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color(0xffF2F2F5),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            vacancy.schedule.toString(),
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ) :
                    Container(),
                    SizedBox(height: 15),
                    Text(
                      vacancy.name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(height: 10),
                    page == 'discover' ?
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: vacancy.description,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black45
                            )
                        ),
                      ),
                    ) :
                    SizedBox(),
                    SizedBox(height: 20),
                    index == null || index <= 2 ?
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          page == 'submit' ?
                          Container() :
                          CustomButton(
                            width:
                            MediaQuery.of(context).size.width *
                                0.35,
                            height:
                            MediaQuery.of(context).size.height *
                                0.07,
                            padding: EdgeInsets.all(5),
                            color: Colors.grey[200],
                            textColor: kColorPrimary,
                            onPressed: () async {
                              if (Prefs.getString(Prefs.TOKEN) == null) {

                                if(Prefs.getInt(Prefs.OFFSET) > 0 && Prefs.getInt(Prefs.OFFSET) != null){
                                  offset = Prefs.getInt(Prefs.OFFSET);
                                }

                                print(offset);

                                props.listResponse.data.removeLast();
                                // StoreProvider.of<AppState>(context).state.vacancy.list.data.remove(vacancy);
                                StoreProvider.of<AppState>(context).dispatch(getNumberOfActiveVacancies());

                                await Vacancy.getVacancyByOffset(

                                    offset: /*offset<0?0:offset*/ offset,
                                    job_type_ids: StoreProvider.of<AppState>(context).state.vacancy.job_type_ids,
                                    region_ids: StoreProvider.of<AppState>(context).state.vacancy.region_ids,
                                    schedule_ids: StoreProvider.of<AppState>(context).state.vacancy.schedule_ids,
                                    busyness_ids: StoreProvider.of<AppState>(context).state.vacancy.busyness_ids,
                                    vacancy_type_ids: StoreProvider.of<AppState>(context).state.vacancy.vacancy_type_ids,
                                    type: StoreProvider.of<AppState>(context).state.vacancy.type

                                ).then((value) {

                                  if (value != null) {
                                    offset = offset + 1;
                                    Prefs.setInt(Prefs.OFFSET, offset);
                                    // setState(() {
                                    props.listResponse.data.insert(0, value);
                                    // StoreProvider.of<AppState>(context).state.vacancy.list.data.insert(0, value);
                                    // });
                                  }

                                });

                                // removeCards(
                                //     props: props,
                                //     type: "DISLIKED",
                                //     vacancy_id: vacancy.id,
                                //     context: context);

                              } else if (page == 'discover') {
                                Vacancy.saveVacancyUser(vacancy_id: vacancy.id,type: "DISLIKED");
                                StoreProvider.of<AppState>(context).state.vacancy.list.data.remove(vacancy);
                                StoreProvider.of<AppState>(context).state.vacancy.list.data.insert(0,
                                    await Vacancy.getVacancyByOffset(
                                        offset: /*offset<0?0:offset*/ 4,
                                        job_type_ids:StoreProvider.of<AppState>(context).state.vacancy.job_type_ids,
                                        region_ids: StoreProvider.of<AppState>(context).state.vacancy.region_ids,
                                        schedule_ids: StoreProvider.of<AppState>(context).state.vacancy.schedule_ids,
                                        busyness_ids: StoreProvider.of<AppState>(context).state.vacancy.busyness_ids,
                                        vacancy_type_ids: StoreProvider.of<AppState>(context).state.vacancy.vacancy_type_ids,
                                        type: StoreProvider.of<AppState>(context).state.vacancy.type)
                                );
                                StoreProvider.of<AppState>(context).dispatch(getNumberOfSubmittedVacancies());
                              } else if (page == 'match') {
                                Vacancy.saveVacancyUser(
                                    vacancy_id: vacancy.id,
                                    type: "LIKED_THEN_DELETED")
                                    .then((value) {
                                  StoreProvider.of<AppState>(context).state.vacancy.liked_list.data.remove(vacancy);
                                  StoreProvider.of<AppState>(context).dispatch(getNumberOfLikedVacancies());
                                });
                              } else if (page == 'company' || page == 'company_inactive') {
                                _showOnDeleteDialog(context,'delete_are_you_sure'.tr());
                              }
                            },
                            text: page == 'discover' ? 'skip'.tr() : 'delete'.tr(),
                          ),
                          Prefs.getString(Prefs.TOKEN) != null ?
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: CustomButton(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.07,
                              padding: EdgeInsets.all(5),
                              color: kColorPrimary,
                              textColor: Colors.white,
                              onPressed: () async {
//                                _openLoadingDialog(context);
                                if (page == 'discover') {
                                  Vacancy.saveVacancyUser(
                                      vacancy_id: vacancy.id,
                                      type: "LIKED");
                                  StoreProvider.of<AppState>(
                                      context)
                                      .state
                                      .vacancy
                                      .list
                                      .data
                                      .remove(vacancy);
                                  StoreProvider.of<AppState>(context).state.vacancy.list.data.insert(
                                      0,
                                      await Vacancy.getVacancyByOffset(
                                          offset: /*offset<0?0:offset*/ 4,
                                          job_type_ids:
                                          StoreProvider.of<AppState>(context)
                                              .state
                                              .vacancy
                                              .job_type_ids,
                                          region_ids: StoreProvider.of<
                                              AppState>(context)
                                              .state
                                              .vacancy
                                              .region_ids,
                                          schedule_ids:
                                          StoreProvider.of<AppState>(context)
                                              .state
                                              .vacancy
                                              .schedule_ids,
                                          busyness_ids:
                                          StoreProvider.of<AppState>(context)
                                              .state
                                              .vacancy
                                              .busyness_ids,
                                          vacancy_type_ids:
                                          StoreProvider.of<AppState>(context)
                                              .state
                                              .vacancy
                                              .vacancy_type_ids,
                                          type: StoreProvider.of<AppState>(
                                              context)
                                              .state
                                              .vacancy
                                              .type));
                                  StoreProvider.of<AppState>(
                                      context)
                                      .dispatch(
                                      getNumberOfLikedVacancies());
                                } else if (page == 'match') {
                                  _openLoadingDialog(context);
                                  User.checkUserCv(Prefs.getInt(Prefs.USER_ID))
                                      .then((value) {
                                    if (value) {
                                      Vacancy.saveVacancyUser(
                                          vacancy_id:
                                          vacancy.id,
                                          type: "SUBMITTED")
                                          .then((value) {
                                        if (value == "OK") {
                                          _showDialog(
                                              context,
                                              "successfully_submitted"
                                                  .tr());
                                          StoreProvider.of<
                                              AppState>(context)
                                              .state
                                              .vacancy
                                              .liked_list
                                              .data
                                              .remove(vacancy);
                                          StoreProvider.of<
                                              AppState>(context)
                                              .dispatch(
                                              getLikedVacancies());
                                          StoreProvider.of<
                                              AppState>(context)
                                              .dispatch(
                                              getNumberOfLikedVacancies());
                                        } else {
                                          _showDialog(context, "some_errors_occured_try_again".tr());
                                        }
                                      });
                                    } else {
                                      _showDialog(context, "please_fill_user_cv_to_submit".tr());
                                    }
                                  });
                                } else if (page == 'company') {
                                  _showOnDeactivateDialog(
                                      context,
                                      'deactivate_are_you_sure'
                                          .tr(),
                                      false);
                                } else if (page ==
                                    'company_inactive') {
                                  _showOnDeactivateDialog(
                                      context,
                                      'activate_are_you_sure'.tr(),
                                      true);
                                } else if (page == 'submit') {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder:
                                          (BuildContext context) {
                                        return ChatScreen(
                                          user_id: vacancy.company,
                                          name: vacancy.company_name,
                                          avatar: vacancy.company_logo,
                                        );
                                      }));
                                }
                              },
                              text: page == 'discover'
                                  ? 'like'.tr()
                                  : (page == 'company'
                                  ? 'deactivate'.tr()
                                  : page == 'company_inactive'
                                  ? 'activate'.tr()
                                  : page == 'submit'
                                  ? 'write_to'.tr()
                                  : 'submit'.tr()),
                            ),
                          ) : Container(),
                        ],
                      ),
                    ) :
                    Container(),
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
