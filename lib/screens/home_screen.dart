import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:ishapp/constants/constants.dart';
import 'package:ishapp/tabs/conversations_tab.dart';
import 'package:ishapp/tabs/discover_tab.dart';
import 'package:ishapp/tabs/matches_tab.dart';
import 'package:ishapp/tabs/profile_tab.dart';
import 'package:ishapp/utils/constants.dart';
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
  bool is_profile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: is_profile ? Colors.white : kColorPrimary,
      appBar: AppBar(
        backgroundColor: is_profile ? Colors.white : kColorPrimary,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
//          children: [
//            Image.asset("assets/images/app_logo.png", width: 40, height: 40),
//            SizedBox(width: 5),
//            Text(APP_NAME),
//          ],
        ),
        actions: [
//          IconButton(
//              icon: SvgIcon("assets/icons/bell_icon.svg"),
//              onPressed: () {
//                /// Go to Notifications Screen
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => NotificationsScreen()));
//              })
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: Platform.isIOS ? 0 : 8,
          currentIndex: _tabCurrentIndex,
          onTap: (index) {
            _nextTab(index);
            if(index == 3 || index == 2){
              setState(() {
                is_profile =true;
              });
            }
            else {
              setState(() {
                is_profile =false;
              });
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Boxicons.bx_search, color: _tabCurrentIndex == 0
                  ? kColorPrimary
                  : null,),
              title: Text("search".tr(), style: TextStyle(color: _tabCurrentIndex == 0
                  ? kColorPrimary
                  : Colors.grey),)),
            BottomNavigationBarItem(
                icon: Icon(Boxicons.bx_like, color: _tabCurrentIndex == 1
                    ? kColorPrimary
                    : null,),
                title: Text("matches".tr(), style: TextStyle(color: _tabCurrentIndex == 1
                    ? kColorPrimary
                    : Colors.grey),)),
            BottomNavigationBarItem(
                icon: Icon(Boxicons.bx_comment_detail, color: _tabCurrentIndex == 2
                  ? kColorPrimary
                  : null,),
                title: Text("chat".tr(), style: TextStyle(color: _tabCurrentIndex == 2
                    ? kColorPrimary
                    : Colors.grey),)),
            BottomNavigationBarItem(
                icon: Icon(Boxicons.bx_user, color: _tabCurrentIndex == 3
                    ? kColorPrimary
                    : null,),
                title: Text("profile".tr(), style: TextStyle(color: _tabCurrentIndex == 3
                    ? kColorPrimary
                    : Colors.grey),)),
          ]),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [DiscoverTab(), MatchesTab(), ConversationsTab(), ProfileTab()],
      ),
    );
  }
}
