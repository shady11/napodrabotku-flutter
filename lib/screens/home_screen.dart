import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ishapp/constants/constants.dart';
import 'package:ishapp/tabs/conversations_tab.dart';
import 'package:ishapp/tabs/discover_tab.dart';
import 'package:ishapp/tabs/matches_tab.dart';
import 'package:ishapp/tabs/profile_tab.dart';
import 'package:ishapp/widgets/svg_icon.dart';

import 'notifications_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variables
  final _pageController = new PageController();
  int _tabCurrentIndex = 0;

  // Tab navigation
  void _nextTab(int tabIndex) {
    // Update tab index
    setState(() => _tabCurrentIndex = tabIndex);

    // Update page index
    _pageController.animateToPage(tabIndex,
        duration: Duration(microseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/images/app_logo.png", width: 40, height: 40),
            SizedBox(width: 5),
            Text(APP_NAME),
          ],
        ),
        actions: [
          IconButton(
              icon: SvgIcon("assets/icons/bell_icon.svg"),
              onPressed: () {
                /// Go to Notifications Screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsScreen()));
              })
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: Platform.isIOS ? 0 : 8,
          currentIndex: _tabCurrentIndex,
          onTap: (index) {
            _nextTab(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgIcon("assets/icons/search_icon.svg",
                  width: 27, height: 27,
                  color: _tabCurrentIndex == 0
                    ? Theme.of(context).primaryColor
                    : null),
              title: Text("Discover")),
            BottomNavigationBarItem(
                icon: SvgIcon("assets/icons/heart_icon.svg",
                    color: _tabCurrentIndex == 1
                        ? Theme.of(context).primaryColor
                        : null),
                title: Text("Matches")),
            BottomNavigationBarItem(
                icon: SvgIcon("assets/icons/message_icon.svg",
                    width: 27, height: 27,
                    color: _tabCurrentIndex == 2
                        ? Theme.of(context).primaryColor
                        : null),
                title: Text("Conversations")),
            BottomNavigationBarItem(
                icon: SvgIcon("assets/icons/user_icon.svg",
                    color: _tabCurrentIndex == 3
                        ? Theme.of(context).primaryColor
                        : null),
                title: Text("Profile")),
          ]),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [DiscoverTab(), MatchesTab(), ConversationsTab(), ProfileTab()],
      ),
    );
  }
}
