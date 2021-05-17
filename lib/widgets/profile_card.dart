import 'package:flutter/material.dart';
import 'package:ishtapp/datas/RSAA.dart';
import 'package:ishtapp/datas/user.dart';
import 'package:ishtapp/datas/vacancy.dart';
import 'package:ishtapp/tabs/discover_tab.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ishtapp/datas/app_state.dart';
import 'package:ishtapp/components/custom_button.dart';
import 'default_card_border.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/datas/pref_manager.dart';
import 'package:ishtapp/constants/configs.dart';
import 'package:ishtapp/screens/chat_screen.dart';
import '../widgets/Dialogs/Dialogs.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class ProfileCard extends StatelessWidget {
  /// User object
  final Vacancy vacancy;
  final VacanciesScreenProps props;

  /// Screen to be checked
  final String page;
  final int index;
  int offset;
  final CardController cardController;

  /// Swiper position
  final SwiperPosition position;

  ProfileCard({
    this.page,
    this.position,
    @required this.vacancy,
    this.index,
    this.offset,
    this.props,
    this.cardController,
  });

  void removeCards({String type, int vacancy_id, props, context}) {
    if (Prefs.getString(Prefs.TOKEN) != null) {
      if (type == "LIKED") {
        props.addOneToMatches();
      }
      Vacancy.saveVacancyUser(vacancy_id: vacancy_id, type: type).then((value) {
        StoreProvider.of<AppState>(context)
            .dispatch(getNumberOfLikedVacancies());
      });
      props.listResponse.data.remove(props.listResponse.data[0]);
    } else {
      props.listResponse.data.removeLast(props.listResponse.data[0]);
    }
    Vacancy.getVacancyByOffset(
            offset: offset,
            job_type_ids:
                StoreProvider.of<AppState>(context).state.vacancy.job_type_ids,
            region_ids:
                StoreProvider.of<AppState>(context).state.vacancy.region_ids,
            schedule_ids:
                StoreProvider.of<AppState>(context).state.vacancy.schedule_ids,
            busyness_ids:
                StoreProvider.of<AppState>(context).state.vacancy.busyness_ids,
            vacancy_type_ids: StoreProvider.of<AppState>(context)
                .state
                .vacancy
                .vacancy_type_ids,
            type: StoreProvider.of<AppState>(context).state.vacancy.type)
        .then((value) {
      if (value != null) {
        offset = offset + 1;
        props.listResponse.data.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            child: vacancy.company_logo != null
                                ? Image.network(
                                    SERVER_IP + vacancy.company_logo,
                                    headers: {
                                      "Authorization":
                                          Prefs.getString(Prefs.TOKEN)
                                    },
                                    width: 70,
                                    height: 70,
                                  )
                                : Image.asset(
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'GTEestiProDisplay',
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: vacancy.region,
                                    style: TextStyle(
                                        fontFamily: 'GTEestiProDisplay',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black45)),
                              ],
                            ),
                          ),
                        ),
                        vacancy.is_disability_person_vacancy == 1
                            ? Icon(
                                Icons.accessible,
                                size: 20,
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color(0xffF2F2F5),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            vacancy.type.toString(),
                            style: TextStyle(
                              color: Colors.black87,
                            ),
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
                              fontFamily: 'GTEestiProDisplay',
                              color: kColorPrimary),
                        )),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color(0xffF2F2F5),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            vacancy.schedule.toString(),
                            style: TextStyle(
                                fontFamily: 'GTEestiProDisplay',
                                color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      vacancy.name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'GTEestiProDisplay',
                          color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    page == 'discover'
                        ? Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: vacancy.description,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'GTEestiProDisplay',
                                      color: Colors.black45)),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          page == 'submit'
                              ? Container()
                              : CustomButton(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  padding: EdgeInsets.all(5),
                                  color: Colors.grey[200],
                                  textColor: kColorPrimary,
                                  onPressed: () async {
                                    if (Prefs.getString(Prefs.TOKEN) == null) {
                                      if (Prefs.getInt(Prefs.OFFSET) > 0 &&
                                          Prefs.getInt(Prefs.OFFSET) != null) {
                                        offset = Prefs.getInt(Prefs.OFFSET);
                                      }
                                      cardController.triggerLeft();

                                      StoreProvider.of<AppState>(context)
                                          .dispatch(
                                              getNumberOfActiveVacancies());
                                    } else if (page == 'discover') {
                                      cardController.triggerLeft();
                                    } else if (page == 'match') {
                                      Vacancy.saveVacancyUser(
                                              vacancy_id: vacancy.id,
                                              type: "LIKED_THEN_DELETED")
                                          .then((value) {
                                        StoreProvider.of<AppState>(context)
                                            .state
                                            .vacancy
                                            .liked_list
                                            .data
                                            .remove(vacancy);
                                        StoreProvider.of<AppState>(context)
                                            .dispatch(
                                                getNumberOfLikedVacancies());
                                      });
                                    } else if (page == 'company' ||
                                        page == 'company_inactive') {
                                      Dialogs.showOnDeleteDialog(context,
                                          'delete_are_you_sure'.tr(), vacancy);
                                    }
                                  },
                                  text: page == 'discover'
                                      ? 'skip'.tr()
                                      : 'delete'.tr(),
                                ),
                          Prefs.getString(Prefs.TOKEN) != null
                              ? Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: CustomButton(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    padding: EdgeInsets.all(5),
                                    color: kColorPrimary,
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      if (page == 'discover') {
                                        cardController.triggerRight();
                                      } else if (page == 'match') {
                                        Dialogs.openLoadingDialog(context);
                                        User.checkUserCv(
                                                Prefs.getInt(Prefs.USER_ID))
                                            .then((value) {
                                          if (value) {
                                            Vacancy.saveVacancyUser(
                                                    vacancy_id: vacancy.id,
                                                    type: "SUBMITTED")
                                                .then((value) {
                                              if (value == "OK") {
                                                Dialogs.showDialogBox(
                                                    context,
                                                    "successfully_submitted"
                                                        .tr());
                                                StoreProvider.of<AppState>(
                                                        context)
                                                    .state
                                                    .vacancy
                                                    .liked_list
                                                    .data
                                                    .remove(vacancy);
                                                StoreProvider.of<AppState>(
                                                        context)
                                                    .dispatch(
                                                        getLikedVacancies());
                                                StoreProvider.of<AppState>(
                                                        context)
                                                    .dispatch(
                                                        getNumberOfLikedVacancies());
                                              } else {
                                                Dialogs.showDialogBox(
                                                    context,
                                                    "some_errors_occured_try_again"
                                                        .tr());
                                              }
                                            });
                                          } else {
                                            Dialogs.showDialogBox(
                                                context,
                                                "please_fill_user_cv_to_submit"
                                                    .tr());
                                          }
                                        });
                                      } else if (page == 'company') {
                                        Dialogs.showOnDeactivateDialog(
                                            context,
                                            'deactivate_are_you_sure'.tr(),
                                            false,
                                            vacancy);
                                      } else if (page == 'company_inactive') {
                                        Dialogs.showOnDeactivateDialog(
                                            context,
                                            'activate_are_you_sure'.tr(),
                                            true,
                                            vacancy);
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
                                )
                              : Container(),
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
