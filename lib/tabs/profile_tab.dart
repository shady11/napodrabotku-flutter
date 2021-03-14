import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:ishapp/components/custom_button.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:ishapp/screens/edit_profile_screen.dart';
import 'package:ishapp/screens/profile_likes_screen.dart';
import 'package:ishapp/screens/profile_screen.dart';
import 'package:ishapp/screens/profile_visits_screen.dart';
import 'package:ishapp/tabs/kk.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/app_section_card.dart';
import 'package:ishapp/widgets/badge.dart';
import 'package:ishapp/widgets/profile_basic_info_card.dart';
import 'package:ishapp/widgets/profile_statistics_card.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/constants/configs.dart';
import 'package:redux/redux.dart';
import 'package:ishapp/datas/RSAA.dart';
import 'package:ishapp/datas/app_state.dart';
import 'package:ishapp/datas/user.dart';

import 'package:flutter_redux/flutter_redux.dart';

class ProfileTab extends StatelessWidget {

  void handleInitialBuild(ProfileScreenProps props) {
    if(Prefs.getString(Prefs.TOKEN) == "null" || Prefs.getString(Prefs.TOKEN) == null ){
    }
    else{
      props.getUser();
      props.getUserCv();
      props.getSubmittedNumber();
    }
  }
 
  // Variables
  final _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileScreenProps>(
      converter: (store) => mapStateToProps(store),
      onInitialBuild: (props) => this.handleInitialBuild(props),
      builder: (context, props) {
        User data = props.user.data;
        bool loading = props.user.loading;
        Widget body;
        if (loading) {
          body = Center(
            child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
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
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundColor: kColorPrimary,
                            radius: 60,
                            backgroundImage: Prefs.getString(Prefs.PROFILEIMAGE) != null ? NetworkImage(
                                SERVER_IP+ Prefs.getString(Prefs.PROFILEIMAGE),headers: {"Authorization": Prefs.getString(Prefs.TOKEN)}) : null,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Text(
                          Prefs.getString(Prefs.TOKEN) != null ? Prefs.getString(Prefs.EMAIL): 'guest_user'.tr(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Prefs.getString(Prefs.TOKEN)!=null?SizedBox(
                            child: CustomButton(
                              height: 50.0,
                              padding: EdgeInsets.all(10),
                              color: kColorPrimary,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.of(context).pushNamed(Routes.user_details);
                              },
                              text: 'view'.tr(),
                            ),
                          ):Container(),
                          Prefs.getString(Prefs.TOKEN)!=null?SizedBox(
                            child: CustomButton(
                              height: 50.0,
                              padding: EdgeInsets.all(10),
                              color: Color(0xffF2F2F5),
                              textColor: kColorPrimary,
                              onPressed: () {
                                Navigator.of(context).pushNamed(Routes.user_edit);
                              },
                              text: 'edit'.tr(),
                            ),
                          ):Container(),
                        ],
                      ),
                    ],
                  ),
                ),
                /// Profile Statistics Card
                Prefs.getString(Prefs.TOKEN) != null ? Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        child: Icon(Boxicons.bx_like, size: 25, color: kColorPrimary,),
                        decoration: BoxDecoration(
                            color: Color(0xffF2F2F5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      title: Text("matches".tr(), style: _textStyle),
                      trailing: Text(StoreProvider.of<AppState>(context).state.vacancy.number_of_likeds.toString(), style: TextStyle(color: Colors.grey[400]),),
                      onTap: () {
                        /// Go to profile likes screen ()
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProfileLikesScreen()));
                      },
                    ),
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        child: Icon(Boxicons.bx_file, size: 25, color: kColorPrimary,),
                        decoration: BoxDecoration(
                            color: Color(0xffF2F2F5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      title: Text("visit".tr(), style: _textStyle),
                      trailing: Text(StoreProvider.of<AppState>(context).state.vacancy.number_of_submiteds !=null ?StoreProvider.of<AppState>(context).state.vacancy.number_of_submiteds.toString():'0', style: TextStyle(color: Colors.grey[400]),),
                      onTap: () {
                        /// Go to profile visits screen
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProfileVisitsScreen()));
                      },
                    ),
                    /*ListTile(
            leading: SvgIcon("assets/icons/close_icon.svg",
                width: 25, height: 25, color: Theme.of(context).primaryColor),
            title: Text("DISLIKED PROFILES", style: _textStyle),
            trailing: Badge(text: "325"),
            onTap: () {
              /// Go to disliked profile screen
              Navigator.push(context, MaterialPageRoute(
                 builder: (context) => DislikedProfilesScreen()));
            },
          ),*/
                  ],
                ): Container(),
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
                      title: Text("about_us".tr(), style: _textStyle),
                      onTap: () {
                        /// Go to About us

                      },
                    ),
                    ListTile(
                      title: Text("privacy_policy".tr(), style: _textStyle),
                      onTap: () async {
                        /// Go to privacy policy
                      },
                    ),
                    Prefs.getString(Prefs.TOKEN) != null ? ListTile(
                      title: Text("logout".tr(), style: TextStyle(fontSize: 18),),
                      onTap: () async {
                        Prefs.setString(Prefs.EMAIL, null);
                        Prefs.setString(Prefs.PROFILEIMAGE, null);
                        Prefs.setString(Prefs.PASSWORD, null);
                        Prefs.setString(Prefs.TOKEN, null);
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.pushReplacementNamed(context, Routes.start);
                      },
                    ): ListTile(
                      title: Text("sign_in".tr(), style: TextStyle(fontSize: 18),),
                      onTap: () async {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.pushReplacementNamed(context, Routes.start);
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Basic profile info
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Profile image
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor: kColorPrimary,
                      radius: 60,
                      backgroundImage: Prefs.getString(Prefs.TOKEN) != null ? NetworkImage(
                          SERVER_IP+ Prefs.getString(Prefs.PROFILEIMAGE),headers: {"Authorization": Prefs.getString(Prefs.TOKEN)}) : null,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    Prefs.getString(Prefs.TOKEN) != null ? Prefs.getString(Prefs.EMAIL): 'guest_user'.tr(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    /// Profile details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),

                        /// Location
                        Row(
                          children: [
                            SvgIcon("assets/icons/location_point_icon.svg",
                                color: Colors.white),
                            SizedBox(width: 5),
                            Text("Бишкек ул. Чехова 28",
                                style: TextStyle(color: Colors.white))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),

                /// Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: CustomButton(
                        height: 50.0,
                        padding: EdgeInsets.all(10),
                        color: kColorPrimary,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.user_details);
                        },
                        text: 'view'.tr(),
                      ),
                    ),
                    SizedBox(
                      child: CustomButton(
                        height: 50.0,
                        padding: EdgeInsets.all(10),
                        color: Color(0xffF2F2F5),
                        textColor: kColorPrimary,
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.user_edit);
                        },
                        text: 'edit'.tr(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          /// Profile Statistics Card
          Prefs.getString(Prefs.TOKEN) != null ? Column(
            children: [
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  child: Icon(Boxicons.bx_like, size: 25, color: kColorPrimary,),
                  decoration: BoxDecoration(
                      color: Color(0xffF2F2F5),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                title: Text("matches".tr(), style: _textStyle),
                trailing: Text('22', style: TextStyle(color: Colors.grey[400]),),
                onTap: () {
                  /// Go to profile likes screen ()
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfileLikesScreen()));
                },
              ),
              ListTile(
                leading: Icon(Boxicons.bx_file, size: 25, color: kColorPrimary,),
                title: Text("visit".tr(), style: _textStyle),
                trailing: Text('15', style: TextStyle(color: Colors.grey[400]),),
                onTap: () {
                  /// Go to profile visits screen
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfileVisitsScreen()));
                },
              ),
              /*ListTile(
            leading: SvgIcon("assets/icons/close_icon.svg",
                width: 25, height: 25, color: Theme.of(context).primaryColor),
            title: Text("DISLIKED PROFILES", style: _textStyle),
            trailing: Badge(text: "325"),
            onTap: () {
              /// Go to disliked profile screen
              Navigator.push(context, MaterialPageRoute(
                 builder: (context) => DislikedProfilesScreen()));
            },
          ),*/
            ],
          ): Container(),
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
                title: Text("about_us".tr(), style: _textStyle),
                onTap: () {
                  /// Go to About us

                },
              ),
              ListTile(
                title: Text("privacy_policy".tr(), style: _textStyle),
                onTap: () async {
                  /// Go to privacy policy
                },
              ),
              Prefs.getString(Prefs.TOKEN) != null ? ListTile(
                title: Text("logout".tr(), style: TextStyle(fontSize: 18),),
                onTap: () async {
                  Prefs.setString(Prefs.EMAIL, null);
                  Prefs.setString(Prefs.PROFILEIMAGE, null);
                  Prefs.setString(Prefs.PASSWORD, null);
                  Prefs.setString(Prefs.TOKEN, null);
                  Navigator.of(context)
                      .popUntil((route) => route.isFirst);
                  Navigator.pushReplacementNamed(context, Routes.start);
                },
              ): ListTile(
                title: Text("sign_in".tr(), style: TextStyle(fontSize: 18),),
                onTap: () async {
                  Navigator.of(context)
                      .popUntil((route) => route.isFirst);
                  Navigator.pushReplacementNamed(context, Routes.start);
                },
              ),
            ],
          ),
        ],
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
    submitted_number:store.state.vacancy.number_of_submiteds,
    getUser: () => store.dispatch(getUser()),
    user_cv: store.state.vacancy.user.user_cv,
    getUserCv: () => store.dispatch(getUserCv()),
    getSubmittedNumber: () => store.dispatch(getNumberOfSubmittedVacancies())
  );
}
