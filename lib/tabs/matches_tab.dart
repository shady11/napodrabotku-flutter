import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/widgets/profile_card.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/widgets/users_grid.dart';

class MatchesTab extends StatefulWidget {
  @override
  _MatchesTabState createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Title

        /// Matches
        Expanded(
          child: UsersGrid(

              children: getDemoVacancies().map((vacancy) {
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
    );
  }
}
