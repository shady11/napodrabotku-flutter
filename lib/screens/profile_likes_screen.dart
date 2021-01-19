import 'package:flutter/material.dart';
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
        title: Text("Likes"),
      ),
      body: Column(
      children: [
        /// Title
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgIcon("assets/icons/heart_icon.svg",
                  color: Theme.of(context).primaryColor),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Users who liked you",
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
          child: UsersGrid(children: getDemoUsers().map((user) {
              /// Return User Card
              return GestureDetector(
                child: ProfileCard(user: user),
                onTap: () {
                  /// Go to profile screen
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileScreen(user: user)));
                },
              );
          }).toList()),
        )
      ],
     )
    );
  }
}
