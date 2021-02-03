import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/screens/profile_screen.dart';
import 'package:ishapp/widgets/profile_card.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/widgets/users_grid.dart';

class ProfileLikesScreen extends StatefulWidget {
  @override
  _ProfileLikesScreenState createState() => _ProfileLikesScreenState();
}

class _ProfileLikesScreenState extends State<ProfileLikesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("likeds".tr()),
      ),
      body: Column(
      children: [
        /// Title

        SizedBox(height: 20),
        /// Matches
        Expanded(
          child: UsersGrid(children: getDemoVacancies().map((vacancy) {
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
     )
    );
  }
}
