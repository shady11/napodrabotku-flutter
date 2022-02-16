import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:ishtapp/components/custom_button.dart';

import 'package:ishtapp/routes/routes.dart';
import 'package:ishtapp/screens/profile_likes_screen.dart';
import 'package:ishtapp/screens/profile_visits_screen.dart';
import 'package:ishtapp/screens/edit_profile_screen.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/datas/pref_manager.dart';
import 'package:ishtapp/constants/configs.dart';
import 'package:redux/redux.dart';
import 'package:ishtapp/datas/RSAA.dart';
import 'package:ishtapp/datas/app_state.dart';
import 'package:ishtapp/datas/user.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_guid/flutter_guid.dart';
import 'package:ishtapp/components/custom_button.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  User user;
  int counter = 0;

  void handleInitialBuild(ProfileScreenProps props) {
    if (Prefs.getString(Prefs.TOKEN) == "null" || Prefs.getString(Prefs.TOKEN) == null) {
    } else {
      props.getUser();
      props.getUserCv();
      props.getSubmittedNumber();
    }
  }

  final _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  showOnDeleteDialog(context, userId) {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        heightFactor: 1 / 2,
        child: AlertDialog(
          backgroundColor: kColorWhite,
          title: Text(''),
          content: Text(
            "Если вы решили удалить аккаунт, вы потеряете всё – и профиль, и связанные с ним данные!",
            style: TextStyle(color: kColorPrimary),
            textAlign: TextAlign.center,
          ),

          actionsPadding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
          actions: <Widget>[
            CustomButton(
              width: MediaQuery.of(context).size.width * 0.3,
              padding: EdgeInsets.all(10),
              color: kColorPrimary,
              textColor: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
              text: 'cancel'.tr(),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              padding: EdgeInsets.all(10),
              child: FlatButton(
                child: Text(
                  'delete'.tr(),
                  style: TextStyle(color: kColorPrimary),
                ),
                onPressed: () {
                  User.deleteUser().then((value) {
                    Prefs.setString(Prefs.EMAIL, null);
                    Prefs.setString(Prefs.PROFILEIMAGE, null);
                    Prefs.setString(Prefs.PASSWORD, null);
                    Prefs.setString(Prefs.TOKEN, null);
                    Prefs.setString(Prefs.USER_TYPE, null);
                    Prefs.setString(Prefs.ROUTE, null);
                    Prefs.setInt(Prefs.USER_ID, null);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacementNamed(context, Routes.select_mode);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileScreenProps>(
      converter: (store) => mapStateToProps(store),
      onInitialBuild: (props) => this.handleInitialBuild(props),
      builder: (context, props) {
        bool loading = props.user.loading;
        Widget body;
        if (loading) {
          body = Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        } else {
          body = SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Basic profile info
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Profile image
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundColor:
                                Prefs.getString(Prefs.ROUTE) == "PRODUCT_LAB" ? kColorProductLab : kColorPrimary,
                            radius: 60,
                            backgroundImage: Prefs.getString(Prefs.PROFILEIMAGE) != null
                                ? NetworkImage(
                                    SERVER_IP + Prefs.getString(Prefs.PROFILEIMAGE) + "?token=${Guid.newGuid}",
                                    headers: {"Authorization": Prefs.getString(Prefs.TOKEN)})
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Text(
                          Prefs.getString(Prefs.TOKEN) != null ? Prefs.getString(Prefs.EMAIL) : 'guest_user'.tr(),
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          /// Profile details
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      /// Buttons
                      Row(
                        mainAxisAlignment: Prefs.getString(Prefs.USER_TYPE) == "USER"
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.center,
                        children: [
                          Prefs.getString(Prefs.TOKEN) != null
                              ? Prefs.getString(Prefs.USER_TYPE) == "USER"
                                  ? SizedBox(
                                      child: CustomButton(
                                        height: 50.0,
                                        padding: EdgeInsets.all(10),
                                        color: Prefs.getString(Prefs.ROUTE) == "PRODUCT_LAB"
                                            ? kColorProductLab
                                            : kColorPrimary,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(Routes.user_details);
                                        },
                                        text: 'profile'.tr(),
                                      ),
                                    )
                                  : Container()
                              : Container(),
                          Prefs.getString(Prefs.TOKEN) != null
                              ? SizedBox(
                                  child: CustomButton(
                                    height: 50.0,
                                    padding: EdgeInsets.all(10),
                                    color: Color(0xffF2F2F5),
                                    textColor: kColorPrimary,
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EditProfileScreen()),
                                      );
                                      setState(() {});
                                    },
                                    text: 'Настройки'.tr(),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),

                /// Profile Statistics Card
                Prefs.getString(Prefs.TOKEN) != null
                    ? Column(
                        children: [
                          ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Boxicons.bx_like,
                                size: 25,
                                color: kColorPrimary,
                              ),
                              decoration:
                                  BoxDecoration(color: Color(0xffF2F2F5), borderRadius: BorderRadius.circular(10)),
                            ),
                            title: Text(
                                Prefs.getString(Prefs.USER_TYPE) == 'USER' ? "matches".tr() : 'active_vacancies'.tr(),
                                style: _textStyle),
                            trailing: Prefs.getString(Prefs.USER_TYPE) == 'USER'
                                ? Text(
                                    StoreProvider.of<AppState>(context).state.vacancy.number_of_likeds != null
                                        ? StoreProvider.of<AppState>(context).state.vacancy.number_of_likeds.toString()
                                        : '0',
                                    style: TextStyle(color: Colors.grey[400]),
                                  )
                                : Text(
                                    StoreProvider.of<AppState>(context).state.vacancy.number_of_active_vacancies != null
                                        ? StoreProvider.of<AppState>(context)
                                            .state
                                            .vacancy
                                            .number_of_active_vacancies
                                            .toString()
                                        : '0',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                            onTap: () {
                              /// Go to profile likes screen ()
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileLikesScreen()));
                            },
                          ),
                          ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Boxicons.bx_file,
                                size: 25,
                                color: kColorPrimary,
                              ),
                              decoration:
                                  BoxDecoration(color: Color(0xffF2F2F5), borderRadius: BorderRadius.circular(10)),
                            ),
                            title: Text(
                                Prefs.getString(Prefs.USER_TYPE) == 'USER' ? "visit".tr() : 'inactive_vacancies'.tr(),
                                style: _textStyle),
                            trailing: Prefs.getString(Prefs.USER_TYPE) == 'USER'
                                ? Text(
                                    StoreProvider.of<AppState>(context).state.vacancy.number_of_submiteds != null
                                        ? StoreProvider.of<AppState>(context)
                                            .state
                                            .vacancy
                                            .number_of_submiteds
                                            .toString()
                                        : '0',
                                    style: TextStyle(color: Colors.grey[400]),
                                  )
                                : Text(
                                    StoreProvider.of<AppState>(context).state.vacancy.number_of_inactive_vacancies !=
                                            null
                                        ? StoreProvider.of<AppState>(context)
                                            .state
                                            .vacancy
                                            .number_of_inactive_vacancies
                                            .toString()
                                        : '0',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                            onTap: () {
                              /// Go to profile visits screen
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileVisitsScreen()));
                            },
                          ),
                        ],
                      )
                    : Container(),
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
                      title: Text("about_app".tr(), style: _textStyle),
                      onTap: () {
                        /// Go to About us
                        Navigator.pushNamed(context, Routes.about);
                      },
                    ),
                    ListTile(
                      title: Text("privacy_policy".tr(), style: _textStyle),
                      onTap: () async {
                        /// Go to privacy policy
                        Navigator.pushNamed(context, Routes.user_policy);
                      },
                    ),
                    ListTile(
                      title: Text("Удалить аккаунт".tr(), style: _textStyle),
                      onTap: () => showOnDeleteDialog(context, 1),
                    ),
                    Prefs.getString(Prefs.USER_TYPE) == 'USER'
                        ? ListTile(
                            title: Text("reset_settings".tr(), style: _textStyle),
                            onTap: () async {
                              user = StoreProvider.of<AppState>(context).state.user.user.data;
                              user.resetSettings(email: user.email);
                              _showDialog(context, 'successful_reset'.tr(), false);
                            },
                          )
                        : Container(),
                    Prefs.getString(Prefs.TOKEN) != null
                        ? ListTile(
                            title: Text(
                              "logout".tr(),
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () async {
                              Prefs.setString(Prefs.EMAIL, null);
                              Prefs.setString(Prefs.PROFILEIMAGE, null);
                              Prefs.setString(Prefs.PASSWORD, null);
                              Prefs.setString(Prefs.TOKEN, null);
                              Prefs.setString(Prefs.USER_TYPE, "USER");
                              Prefs.setString(Prefs.ROUTE, null);
                              Prefs.setInt(Prefs.USER_ID, null);
                              Navigator.of(context).popUntil((route) => route.isFirst);
                              Navigator.pushReplacementNamed(context, Routes.select_mode);
                            },
                          )
                        : ListTile(
                            title: Text(
                              "sign_in".tr(),
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () async {
                              Navigator.of(context).popUntil((route) => route.isFirst);
                              Navigator.pushReplacementNamed(context, Routes.select_mode);
                            },
                          ),
                  ],
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: body,
        );
      },
    );
  }

  void _showDialog(context, String message, bool error) {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        child: AlertDialog(
          title: Text(''),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('continue'.tr()),
              onPressed: () {
                Navigator.of(ctx).pop();
                if (!error){
                  Prefs.getString(Prefs.ROUTE) == "PRODUCT_LAB"
                      ?  Navigator.pushReplacementNamed(context, Routes.product_lab_home)
                      : Navigator.pushReplacementNamed(context, Routes.home);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class ProfileScreenProps {
  final Function getUser;
  final Function getUserCv;
  final Function getSubmittedNumber;
  final UserDetailState user;
  final UserCvState user_cv;
  final int submitted_number;

  ProfileScreenProps({
    this.getUser,
    this.user,
    this.getUserCv,
    this.user_cv,
    this.getSubmittedNumber,
    this.submitted_number,
  });
}

ProfileScreenProps mapStateToProps(Store<AppState> store) {
  return ProfileScreenProps(
      user: store.state.vacancy.user.user,
      submitted_number: store.state.vacancy.number_of_submiteds,
      getUser: () => store.dispatch(getUser()),
      user_cv: store.state.vacancy.user.user_cv,
      getUserCv: () => store.dispatch(getUserCv()),
      getSubmittedNumber: () => store.dispatch(getNumberOfSubmittedVacancies()));
}
