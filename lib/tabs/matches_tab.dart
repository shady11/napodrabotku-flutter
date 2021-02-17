import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/datas/vacancy.dart';
import 'package:ishapp/widgets/profile_card.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/widgets/users_grid.dart';

class MatchesTab extends StatefulWidget {
  @override
  _MatchesTabState createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {

  List<Vacancy> vacancyList = new List<Vacancy>();

  getget(){
    Vacancy.getVacancyListByType(10, 0, 'LIKED').then((value) {
      setState(() {
        vacancyList = value;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    getget();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: vacancyList.length!=0 ? Column(
        children: [
          Expanded(
            child: UsersGrid(
                children: vacancyList.map((vacancy) {
                /// Return User Card
                return GestureDetector(
                  child: ProfileCard(vacancy: vacancy),
                  onTap: () {
                    /// Go to profile screen
//                  Navigator.of(context).push(MaterialPageRoute(
//                    builder: (context) => ProfileScreen(user: user)));
                  },
                );
            }).toList()),
          )
        ],
      ) : Center(
        heightFactor: 20,
        widthFactor: 20,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 10,
        ),
      ),
    );
  }
}
