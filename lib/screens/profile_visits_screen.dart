import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/datas/vacancy.dart';
import 'package:ishapp/screens/profile_screen.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/profile_card.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/widgets/users_grid.dart';

class ProfileVisitsScreen extends StatefulWidget {
  @override
  _ProfileVisitsScreenState createState() => _ProfileVisitsScreenState();
}

class _ProfileVisitsScreenState extends State<ProfileVisitsScreen> {

  List<Vacancy> vacancyList = new List<Vacancy>();
  bool loading = false;

  getget() async {
//    await Future.delayed(Duration(seconds: 3));
    Vacancy.getVacancyListByType(10, 0, 'SUBMIT').then((value) {
      setState(() {
        vacancyList = value;
        loading = true;
      });
    });
  }

  @override
  void initState() {
    getget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPrimary,
      appBar: AppBar(
        title: Text("visit".tr()),
      ),
      body: Column(
      children: [
        /// Title
        SizedBox(height: 20,),

        /// Matches
      loading ? Expanded(
          child: vacancyList.length != 0 ? UsersGrid(children: vacancyList.map((vacancy) {
              /// Return User Card
              return GestureDetector(
                child: ProfileCard(vacancy: vacancy),
                onTap: () {
                  /// Go to profile screen
//                  Navigator.of(context).push(MaterialPageRoute(
//                    builder: (context) => ProfileScreen(user: user)));
                },
              );
          }).toList()) : Container(),
        ):  Center(
        heightFactor: 20,
        widthFactor: 20,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 10,
        ),
      ),
      ],
     )
    );
  }
}
