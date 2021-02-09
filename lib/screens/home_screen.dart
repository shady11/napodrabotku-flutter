import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'package:ishapp/widgets/cicle_button.dart';
import 'package:ishapp/components/custom_button.dart';
import 'package:ishapp/constants/constants.dart';
import 'package:ishapp/tabs/conversations_tab.dart';
import 'package:ishapp/tabs/discover_tab.dart';
import 'package:ishapp/tabs/matches_tab.dart';
import 'package:ishapp/tabs/profile_tab.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/datas/vacancy.dart';

import 'notifications_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _formKey = GlobalKey<FormState>();
  List<String> selectedJobTypeChoices = List();
  List<String> selectedVacancyTypeChoices = List();
  List<String> selectedBusynessChoices = List();
  List<String> selectedScheduleChoices = List();

  List<dynamic> jobTypeList = [];
  List<JobType> _selectedJobTypes = [];
  List<dynamic> vacancyTypeList = [];
  List<dynamic> busynessList = [];
  List<dynamic> scheduleList = [];

  List<int> _job_types;
  List<int> _vacancy_types;
  List<int> _busynesses;
  List<int> _schedules;
  
  getLists() async{
    jobTypeList = await Vacancy.getLists('job_type');
    vacancyTypeList = await Vacancy.getLists('vacancy_type');
    busynessList = await Vacancy.getLists('busyness');
    scheduleList = await Vacancy.getLists('schedule');
  }
  


  openFilterDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text('search_filter'.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),)
                    ),
                    SizedBox(height: 30,),
                    /// Form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          MultiSelectFormField(
                            autovalidate: false,
                            title: Text('job_types'.tr(), style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return 'select_one_or_more'.tr();
                              }
                            },
                            dataSource: jobTypeList,
                            textField: 'name',
                            valueField: 'id',
                            okButtonLabel: 'search'.tr(),
                            cancelButtonLabel: 'cancel'.tr(),
                            // required: true,
                            hintWidget: Text('select_one_or_more'.tr()),
                            initialValue: _job_types,
                            onSaved: (value) {
                              if (value == null) return;
                              setState(() {
                                _job_types = value;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          MultiSelectFormField(
                            autovalidate: false,
                            title: Text('vacancy_types'.tr(), style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return 'select_one_or_more'.tr();
                              }
                            },
                            dataSource: vacancyTypeList,
                            textField: 'name',
                            valueField: 'id',
                            okButtonLabel: 'ok'.tr(),
                            cancelButtonLabel: 'cancel'.tr(),
                            // required: true,
                            hintWidget: Text('select_one_or_more'.tr()),
                            initialValue: _vacancy_types,
                            onSaved: (value) {
                              if (value == null) return;
                              setState(() {
                                _vacancy_types = value;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          MultiSelectFormField(
                            autovalidate: false,
                            title: Text('busynesses'.tr(), style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return 'select_one_or_more'.tr();
                              }
                            },
                            dataSource: busynessList,
                            textField: 'name',
                            valueField: 'id',
                            okButtonLabel: 'ok'.tr(),
                            cancelButtonLabel: 'cancel'.tr(),
                            // required: true,
                            hintWidget: Text('select_one_or_more'.tr()),
                            initialValue: _busynesses,
                            onSaved: (value) {
                              if (value == null) return;
                              setState(() {
                                _busynesses = value;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          MultiSelectFormField(
                            autovalidate: false,
                            title: Text('schedules'.tr(), style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return 'select_one_or_more'.tr();
                              }
                            },
                            dataSource: scheduleList,
                            textField: 'name',
                            valueField: 'id',
                            okButtonLabel: 'ok'.tr(),
                            cancelButtonLabel: 'cancel'.tr(),
                            // required: true,
                            hintWidget: Text('select_one_or_more'.tr()),
                            initialValue: _schedules,
                            onSaved: (value) {
                              if (value == null) return;
                              setState(() {
                                _schedules = value;
                              });
                            },
                          ),
                          SizedBox(height: 30),

                          /// Sign In button
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                  width:MediaQuery.of(context).size.width * 0.3,
                                  padding: EdgeInsets.all(10),
                                  color: Colors.grey[200],
                                  textColor: kColorPrimary,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  text: 'cancel'.tr(),
                                ),
                                CustomButton(
                                  width:MediaQuery.of(context).size.width * 0.3,
                                  padding: EdgeInsets.all(10),
                                  color: kColorPrimary,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  text: 'search'.tr(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
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

  List<Widget> app_bar_titles=[];

  buildSome(BuildContext context){
    app_bar_titles = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('ishtapp'.tr(),
            style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic
            ),
          ),
          GestureDetector(
            child: CircleButton(
                bgColor: Colors.transparent,
                padding: 12,
                icon: Icon(Boxicons.bx_filter, color: Colors.white, size: 35,)
            ),
            onTap: () {
              openFilterDialog( context);
            },
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('matches'.tr(),
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('sms'.tr(),
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('profile'.tr(),
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)
          ),
        ],
      ),
    ];
  }
  bool is_profile = false;


  @override
  void initState() {
    super.initState();
    buildSome(context);
    getLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: is_profile ? Colors.white : kColorPrimary,
      appBar: AppBar(
        backgroundColor: is_profile ? Colors.white : kColorPrimary,
        elevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Container(
//          padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
          width: MediaQuery.of(context).size.width * 1.0,
          child: app_bar_titles[_tabCurrentIndex],
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
      bottomNavigationBar: ClipRRect(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
    ),
        child: BottomNavigationBar(
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
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [DiscoverTab(limit: 10, offset: 0,), MatchesTab(), ConversationsTab(), ProfileTab()],
      ),
    );
  }
}
