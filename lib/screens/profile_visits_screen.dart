import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishapp/datas/RSAA.dart';
import 'package:ishapp/datas/app_state.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/datas/vacancy.dart';
import 'package:ishapp/screens/profile_screen.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/profile_card.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/widgets/users_grid.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux/flutter_redux.dart';

class ProfileVisitsScreen extends StatelessWidget {
  void handleInitialBuild(VacanciesScreenProps1 props) {
    props.getSubmittedVacancies();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VacanciesScreenProps1>(
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
                child: UsersGrid(
                    children: data.map((vacancy) {
                      return GestureDetector(
                        child: ProfileCard(vacancy: vacancy, page:"submit"),
                        onTap: () {
//                  Navigator.of(context).push(MaterialPageRoute(
//                    builder: (context) => ProfileScreen(user: user)));
                        },
                      );
                    }).toList()),
              )
            ],
          );
        }


        return Scaffold(
          backgroundColor: kColorPrimary,
          appBar: AppBar(
            title: Text("visit".tr()),
          ),
          body: body,
        );
      },
    );
  }
}

class VacanciesScreenProps1 {
  final Function getSubmittedVacancies;
  final ListSubmittedVacancyState listResponse1;

  VacanciesScreenProps1({
    this.getSubmittedVacancies,
    this.listResponse1,
  });
}

VacanciesScreenProps1 mapStateToProps(Store<AppState> store) {
  return VacanciesScreenProps1(
    listResponse1: store.state.vacancy.submitted_list,
    getSubmittedVacancies: () => store.dispatch(getSubmittedVacancies()),
  );
}
