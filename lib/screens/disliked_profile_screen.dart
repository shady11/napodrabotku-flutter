import 'package:flutter/material.dart';
import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/screens/profile_screen.dart';
import 'package:ishapp/widgets/profile_card.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/widgets/users_grid.dart';

class DislikedProfilesScreen extends StatefulWidget {
  @override
  _DislikedProfilesScreenState createState() => _DislikedProfilesScreenState();
}

class _DislikedProfilesScreenState extends State<DislikedProfilesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disliked profiles"),
      ),
      body: Column(
      children: [
        /// Title
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgIcon("assets/icons/close_icon.svg",
                  width: 30, height: 30,
                  color: Theme.of(context).primaryColor),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Profiles you rejected",
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ),

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
