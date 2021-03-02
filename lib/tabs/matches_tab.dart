import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:ishapp/components/custom_button.dart';
import 'package:ishapp/datas/RSAA.dart';
import 'package:ishapp/datas/app_state.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/datas/vacancy.dart';
import 'package:ishapp/widgets/profile_card.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/widgets/users_grid.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux/flutter_redux.dart';

class MatchesTab extends StatelessWidget {

  void handleInitialBuild(VacanciesScreenProps1 props) {
    props.getLikedVacancies();
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
                        child: ProfileCard(vacancy: vacancy),
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

        return body;
      },
    );
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
