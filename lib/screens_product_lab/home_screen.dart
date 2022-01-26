import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ishtapp/datas/pref_manager.dart';
import 'package:ishtapp/tabs_product_lab/discover_tab.dart';
import 'package:ishtapp/widgets/cicle_button.dart';
import 'package:ishtapp/tabs/matches_tab.dart';
import 'package:ishtapp/tabs/profile_tab.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ishtapp/datas/app_state.dart';
import 'package:ishtapp/widgets/badge.dart';
import 'package:ishtapp/tabs/conversations_tab.dart';
import 'package:ishtapp/tabs/school_tab.dart';

class ProductLabHome extends StatefulWidget {
  const ProductLabHome({Key key}) : super(key: key);

  @override
  _ProductLabHomeState createState() => _ProductLabHomeState();
}

class _ProductLabHomeState extends State<ProductLabHome> {
  DateTime currentBackPressTime;
  final _pageController = new PageController();
  List<Widget> app_bar_titles = [];
  int _tabCurrentIndex = 0;
  bool is_profile = false;
  bool is_special = false;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(context, msg: 'click_once_to_exit'.tr());
      return Future.value(false);
    }
    return Future.value(true);
  }

  buildSome(BuildContext context) {
    app_bar_titles = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Product Lab'.tr(),
            style:
                TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
          ),
          GestureDetector(
            child: CircleButton(
                bgColor: Colors.transparent,
                padding: 12,
                icon: Icon(
                  Prefs.getString(Prefs.USER_TYPE) == 'COMPANY' ? Boxicons.bxs_plus_square : Boxicons.bx_filter,
                  color: Colors.white,
                  size: 35,
                )),
            onTap: () async {
              // Prefs.getString(Prefs.USER_TYPE) == 'COMPANY'
              //     ? await openVacancyForm(context)
              //     : await openFilterDialog(context);
            },
          ),
          GestureDetector(
            child: CircleButton(
              bgColor: Colors.transparent,
              padding: 12,
              icon: Icon(
                Boxicons.bx_user,
                color: Colors.white,
                size: 35,
              ),
            ),
            onTap: () {
              _nextTab(4);
              setState(() {
                is_profile = true;
              });
            },
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('matches'.tr(), style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600)),
          GestureDetector(
            child: CircleButton(
              bgColor: Colors.transparent,
              padding: 12,
              icon: Icon(
                Boxicons.bx_user,
                color: Colors.white,
                size: 35,
              ),
            ),
            onTap: () {
              _nextTab(4);
              setState(() {
                is_profile = true;
              });
            },
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'chat'.tr(),
            /*style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)*/
          ),
          GestureDetector(
            child: CircleButton(
              bgColor: Colors.transparent,
              padding: 12,
              icon: Icon(
                Boxicons.bx_user,
                color: kColorPrimary,
                size: 35,
              ),
            ),
            onTap: () {
              // _nextTab(4);
              setState(() {
                // is_profile = true;
              });
            },
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'training'.tr(),
          ),
          GestureDetector(
            child: CircleButton(
              bgColor: Colors.transparent,
              padding: 12,
              icon: Icon(
                Boxicons.bx_user,
                color: kColorPrimary,
                size: 35,
              ),
            ),
            onTap: () {
              // _nextTab(4);
              setState(() {
                // is_profile = true;
              });
            },
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('profile'.tr(), style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w600)),
        ],
      ),
    ];
  }

  void _nextTab(int tabIndex, {is_profile = false}) {
    // Update tab index
    setState(() => _tabCurrentIndex = tabIndex);
    setState(() => is_profile = true);
    // Update page index
    _pageController.animateToPage(tabIndex, duration: Duration(microseconds: 500), curve: Curves.ease);
  }

  @override
  void initState() {
    buildSome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: is_profile ? Colors.white : kColorPrimary,
        appBar: is_special
            ? AppBar(
                automaticallyImplyLeading: false,
                title: Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  child: app_bar_titles[_tabCurrentIndex],
                ),
              )
            : AppBar(
                backgroundColor: is_profile ? Colors.white : kColorPrimary,
                elevation: 0,
                toolbarHeight: 80,
                automaticallyImplyLeading: false,
                title: Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  child: app_bar_titles[_tabCurrentIndex],
                ),
                actions: [],
              ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            iconSize: 25,
            type: BottomNavigationBarType.fixed,
            elevation: Platform.isIOS ? 0 : 8,
            selectedItemColor: Colors.grey[600],
            selectedFontSize: _tabCurrentIndex == 4 ? 13 : 14,
            currentIndex: _tabCurrentIndex == 4 ? 0 : _tabCurrentIndex,
            onTap: (index) {
              _nextTab(index);
              if (index == 3 || index == 2) {
                setState(() {
                  is_special = true;
                  is_profile = true;
                });
              } else {
                setState(() {
                  is_special = false;
                  is_profile = false;
                });
              }
            },
            items: [
              Prefs.getString(Prefs.USER_TYPE) == 'COMPANY'
                  ? BottomNavigationBarItem(
                      icon: Icon(
                        Boxicons.bx_briefcase,
                        color: _tabCurrentIndex == 0 ? kColorPrimary : null,
                      ),
                      title: Text(
                        "vacancies".tr(),
                        style: TextStyle(color: _tabCurrentIndex == 0 ? kColorPrimary : null),
                      ))
                  : BottomNavigationBarItem(
                      icon: Icon(
                        Boxicons.bx_search,
                        color: _tabCurrentIndex == 0 ? kColorPrimary : null,
                      ),
                      title: Text(
                        "search".tr(),
                        style: TextStyle(color: _tabCurrentIndex == 0 ? kColorPrimary : Colors.grey),
                      )),
              Prefs.getString(Prefs.USER_TYPE) == 'COMPANY'
                  ? BottomNavigationBarItem(
                      icon: Icon(
                        Boxicons.bx_folder,
                        color: _tabCurrentIndex == 1 ? kColorPrimary : null,
                      ),
                      title: Text(
                        "cvs".tr(),
                        style: TextStyle(color: _tabCurrentIndex == 1 ? kColorPrimary : Colors.grey),
                      ))
                  : BottomNavigationBarItem(
                      icon: Container(
                        width: 50,
                        height: 30,
                        child: Stack(children: [
                          Positioned(
                            top: -1.0,
                            left: 0.0,
                            right:
                                StoreProvider.of<AppState>(context).state.vacancy.number_of_likeds == null ? 0.0 : null,
                            child: Icon(
                              Boxicons.bx_like,
                              color: _tabCurrentIndex == 1 ? kColorPrimary : null,
                            ),
                          ),
                          StoreProvider.of<AppState>(context).state.vacancy.number_of_likeds == null
                              ? Container()
                              : Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: StoreProvider.of<AppState>(context).state.vacancy.number_of_likeds > 0
                                      ? Badge(
                                          text: StoreProvider.of<AppState>(context)
                                              .state
                                              .vacancy
                                              .number_of_likeds
                                              .toString())
                                      : Container(),
                                ),
                        ]),
                      ),
                      title: Text(
                        "matches".tr(),
                        style: TextStyle(color: _tabCurrentIndex == 1 ? kColorPrimary : Colors.grey),
                      )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Boxicons.bx_comment_detail,
                    color: _tabCurrentIndex == 2 ? kColorPrimary : null,
                  ),
                  title: Text(
                    "chat".tr(),
                    style: TextStyle(color: _tabCurrentIndex == 2 ? kColorPrimary : Colors.grey),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Boxicons.bx_book,
                    color: _tabCurrentIndex == 4 ? kColorPrimary : null,
                  ),
                  title: Text(
                    "profile".tr(),
                    style: TextStyle(color: _tabCurrentIndex == 4 ? kColorPrimary : Colors.grey),
                  )),
            ],
          ),
        ),
        body: WillPopScope(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                DiscoverTab(),
                MatchesTab(),
                ConversationsTab(),
                SchoolTab(),
                ProfileTab(),
                // DiscoverTab(),
                // MatchesTab(),
                // ConversationsTab(),
                // SchoolTab(),
                // ProfileTab(),
              ],
            ),
            onWillPop: onWillPop),
      ),
    );
  }
}
