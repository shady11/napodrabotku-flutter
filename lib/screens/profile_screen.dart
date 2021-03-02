import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:ishapp/datas/RSAA.dart';
import 'package:ishapp/datas/app_state.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/constants/configs.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'chat_screen.dart';

class ProfileScreen extends StatelessWidget {

  void handleInitialBuild(ProfileScreenProps props) {
    props.getUser();
  }

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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(SERVER_IP+ Prefs.getString(Prefs.PROFILEIMAGE),headers: {"Authorization": Prefs.getString(Prefs.TOKEN)}, width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.2,)
                    ),
                  ),
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
                              currentUserDemo.userFullname,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),

                        ],
                      ),

                      SizedBox(height: 5),

//                      /// Education
//                      _rowProfileInfo(context,
//                          icon: SvgIcon("assets/icons/university_icon.svg",
//                              color: Theme.of(context).primaryColor,
//                              width: 28,
//                              height: 28),
//                          title: user.userSchool),

                      Divider(),

                      /// Profile bio
                      Text('Bio',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black)),
                      SizedBox(height: 10,),
                      Text(DEMO_PROFILE_BIO,
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }


        return Scaffold(
//          backgroundColor: kColorPrimary,
          appBar: AppBar(
            title: Text("profile".tr()),
          ),
          body: body,
        );
      },
    );
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(SERVER_IP+ Prefs.getString(Prefs.PROFILEIMAGE),headers: {"Authorization": Prefs.getString(Prefs.TOKEN)}, width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.2,)
                    ),
                  ),
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
                              currentUserDemo.userFullname,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),

                        ],
                      ),

                      SizedBox(height: 5),

//                      /// Education
//                      _rowProfileInfo(context,
//                          icon: SvgIcon("assets/icons/university_icon.svg",
//                              color: Theme.of(context).primaryColor,
//                              width: 28,
//                              height: 28),
//                          title: user.userSchool),

                      Divider(),

                      /// Profile bio
                      Text('Bio',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black)),
                      SizedBox(height: 10,),
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
        backgroundColor: kColorPrimary,
        child: Icon(Boxicons.bx_message_rounded,  size: 40,),
        onPressed: () {
          /// Go to chat screen
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatScreen(user: currentUserDemo)));
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

class ProfileScreenProps {
  final Function getUser;
  final UserDetailState user;

  ProfileScreenProps({
    this.getUser,
    this.user,
  });
}

ProfileScreenProps mapStateToProps(Store<AppState> store) {
  return ProfileScreenProps(
    user: store.state.vacancy.user.user,
    getUser: () => store.dispatch(getUser()),
  );
}
