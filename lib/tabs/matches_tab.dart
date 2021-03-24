import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:ishapp/components/custom_button.dart';
import 'package:ishapp/datas/RSAA.dart';
import 'package:ishapp/datas/app_state.dart';

import 'package:ishapp/widgets/vacancy_view.dart';
import 'package:ishapp/screens/profile_full_info_screen.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/datas/vacancy.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/profile_card.dart';
import 'package:ishapp/widgets/submitted_user_card.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/widgets/users_grid.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux/flutter_redux.dart';

class MatchesTab extends StatelessWidget {

  void handleInitialBuild(VacanciesScreenProps1 props) {
      props.getLikedVacancies();
  }

  void handleInitialBuildOfSubmits(SubmittedUsersProps props) {
    props.getSubmittedUsers();
  }


  @override
  Widget build(BuildContext context) {
    if(Prefs.getString(Prefs.TOKEN) == "null" || Prefs.getString(Prefs.TOKEN) == null ){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Text("you_cant_see_matches_please_sign_in".tr(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25),),
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
      );
    }
    else{
      return Prefs.getString(Prefs.USER_TYPE)=='COMPANY'
    ?StoreConnector<AppState, SubmittedUsersProps>(
        converter: (store) => mapStateToSubmittedUsersProps(store),
        onInitialBuild: (props) => this.handleInitialBuildOfSubmits(props),
        builder: (context, props) {
          List<User> data = props.listResponse.data;
          bool loading = props.listResponse.loading;

          Widget body;
          if (loading) {
            body = Center(
              child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
            );
          } else {
            body = Column(
              children: [
                Expanded(
                  child: data!=null?UsersGrid(
                      children: data.map((user) {
                        return GestureDetector(
                          child: UserCard(user: user, /*page: 'match',*/),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileInfoScreen(user_id: user.id)));
                          },
                        );
                      }).toList()):Center(
                    child: Text('empty'.tr(), style: TextStyle(color: Colors.white),),
                  ),
                ),

              ],
            );
          }

          return body;
        },
      )
    : StoreConnector<AppState, VacanciesScreenProps1>(
        converter: (store) => mapStateToProps(store),
        onInitialBuild: (props) => this.handleInitialBuild(props),
        builder: (context, props) {
          List<Vacancy> data = props.listResponse1.data;
          bool loading = props.listResponse1.loading;
          Widget body;
          if (loading) {
            body = Center(
              child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
            );
          } else {
            body = Column(
              children: [
                Expanded(
                  child: StoreProvider.of<AppState>(context).state.vacancy.liked_list.data.length !=0?UsersGrid(
                      children: StoreProvider.of<AppState>(context).state.vacancy.liked_list.data.map((vacancy) {
                        return GestureDetector(
                          child: ProfileCard(vacancy: vacancy, page: 'match',),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    backgroundColor: kColorPrimary,
                                    appBar: AppBar(
                                      title: Text("vacancy_view".tr()),
                                    ),
                                    body: VacancyView(
                                      page:"view",
                                      vacancy: vacancy,
                                    ),
                                  );
                                }));
                          },
                        );
                      }).toList()):Center(
                    child: Text('empty'.tr(), style: TextStyle(color: Colors.white),),
                  ),
                ),

              ],
            );
          }

          return body;
        },
      );
    }

  }
}

class VacanciesScreenProps1 {
  final Function getLikedVacancies;
  final LikedVacancyListState listResponse1;

  VacanciesScreenProps1({
    this.getLikedVacancies,
    this.listResponse1,
  });
}

VacanciesScreenProps1 mapStateToProps(Store<AppState> store) {
  return VacanciesScreenProps1(
    listResponse1: store.state.vacancy.liked_list,
    getLikedVacancies: () => store.dispatch(getLikedVacancies()),
  );
}

class SubmittedUsersProps {
  final Function getSubmittedUsers;
  final ListUserDetailState listResponse;

  SubmittedUsersProps({
    this.getSubmittedUsers,
    this.listResponse,
  });
}

SubmittedUsersProps mapStateToSubmittedUsersProps(Store<AppState> store) {
  return SubmittedUsersProps(
    listResponse: store.state.user.submitted_user_list,
    getSubmittedUsers: ()=>store.dispatch(getSubmittedUsers()),
  );
}
