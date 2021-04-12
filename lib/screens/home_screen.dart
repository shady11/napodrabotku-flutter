import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:ishtapp/datas/RSAA.dart';
import 'package:ishtapp/datas/app_state.dart';
import 'package:ishtapp/tabs/school_tab.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ishtapp/widgets/cicle_button.dart';
import 'package:ishtapp/components/custom_button.dart';
import 'package:ishtapp/constants/constants.dart';
import 'package:ishtapp/tabs/conversations_tab.dart';
import 'package:ishtapp/tabs/discover_tab.dart';
import 'package:ishtapp/tabs/matches_tab.dart';
import 'package:ishtapp/tabs/profile_tab.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/datas/vacancy.dart';
import 'package:ishtapp/widgets/badge.dart';
import 'package:ishtapp/datas/pref_manager.dart';
import 'package:ishtapp/routes/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vacancyAddFormKey = GlobalKey<FormState>();
  List<String> selectedJobTypeChoices = List();
  List<String> selectedVacancyTypeChoices = List();
  List<String> selectedBusynessChoices = List();
  List<String> selectedScheduleChoices = List();

  List<dynamic> jobTypeList = [];
  List<dynamic> vacancyTypeList = [];
  List<dynamic> busynessList = [];
  List<dynamic> scheduleList = [];
  List<dynamic> regionList = [];

  List _job_types = [];
  List _vacancy_types = [];
  List _busynesses = [];
  List _schedules = [];
  List _regions = [];

  int _job_type_id;
  int _vacancy_type_id;
  int _busyness_id;
  int _schedule_id;
  int _region_id;
  JobType vacancy_region = new JobType(id: 1, name: 'Бишкек');
  int c = 0;

  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(context, msg: 'click_once_to_exit'.tr());
      return Future.value(false);
    }
    return Future.value(true);
  }

  getLists() async {
    jobTypeList = await Vacancy.getLists('job_type');
    vacancyTypeList = await Vacancy.getLists('vacancy_type');
    busynessList = await Vacancy.getLists('busyness');
    scheduleList = await Vacancy.getLists('schedule');
    regionList = await Vacancy.getLists('region');
  }

  TextEditingController _vacancy_name_controller = TextEditingController();
  TextEditingController _vacancy_salary_controller = TextEditingController();
  TextEditingController _vacancy_description_controller =
      TextEditingController();

  openFilterDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          'search_filter'.tr(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    SizedBox(
                      height: 30,
                    ),

                    /// Form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          MultiSelectFormField(
                            autovalidate: false,
                            title: Text(
                              'regions'.tr(),
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return 'select_one_or_more'.tr();
                              }
                            },
                            dataSource: regionList,
                            textField: 'name',
                            valueField: 'id',
                            okButtonLabel: 'ok'.tr(),
                            cancelButtonLabel: 'cancel'.tr(),
                            // required: true,
                            hintWidget: Text('select_one_or_more'.tr()),
                            initialValue: _regions,
                            onSaved: (value) {
                              if (value == null) return;
                              setState(() {
                                _regions = value;
                              });
                            },
                          ),
//                          SizedBox(height: 20),
                          MultiSelectFormField(
                            autovalidate: false,
                            title: Text(
                              'job_types'.tr(),
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return 'select_one_or_more'.tr();
                              }
                            },
                            dataSource: jobTypeList,
                            textField: 'name',
                            valueField: 'id',
                            okButtonLabel: 'ok'.tr(),
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
//                          SizedBox(height: 20),
                          MultiSelectFormField(
                            autovalidate: false,
                            title: Text(
                              'vacancy_types'.tr(),
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
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
//                          SizedBox(height: 20),
                          MultiSelectFormField(
                            autovalidate: false,
                            title: Text(
                              'busynesses'.tr(),
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
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
//                          SizedBox(height: 20),
                          MultiSelectFormField(
                            autovalidate: false,
                            title: Text(
                              'schedules'.tr(),
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  padding: EdgeInsets.all(10),
                                  color: Colors.grey[200],
                                  textColor: kColorPrimary,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  text: 'cancel'.tr(),
                                ),
                                CustomButton(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  padding: EdgeInsets.all(10),
                                  color: kColorPrimary,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(setFilter(
                                            schedule_ids: _schedules,
                                            busyness_ids: _busynesses,
                                            region_ids: _regions,
                                            vacancy_type_ids: _vacancy_types,
                                            job_type_ids: _job_types));
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(getVacancies());
                                    Navigator.of(context).pop();
                                    _nextTab(0);
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

  openVacancyForm(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.9),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            'search_filter'.tr(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                      SizedBox(
                        height: 30,
                      ),

                      /// Form
                      Form(
                        key: _vacancyAddFormKey,
                        child: Column(
                          children: <Widget>[
                            Align(
                                widthFactor: 10,
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'vacancy_name'.tr(),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )),
                            TextFormField(
                              controller: _vacancy_name_controller,
                              focusNode: FocusNode(canRequestFocus: false),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                              validator: (name) {
                                if (name.isEmpty) {
                                  return "please_fill_this_field".tr();
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Align(
                                widthFactor: 10,
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'vacancy_salary'.tr(),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )),
                            TextFormField(
                              controller: _vacancy_salary_controller,
                              focusNode: FocusNode(canRequestFocus: false),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                              validator: (name) {
                                if (name.isEmpty) {
                                  return "please_fill_this_field".tr();
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Align(
                                widthFactor: 10,
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'vacancy_description'.tr(),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )),
                            TextFormField(
                              controller: _vacancy_description_controller,
                              maxLines: 5,
                              focusNode: FocusNode(canRequestFocus: false),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                              validator: (name) {
                                if (name.isEmpty) {
                                  return "please_fill_this_field".tr();
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            DropdownButton<int>(
                              isExpanded: true,
                              hint: Text("regions".tr()),
                              value: _region_id,
                              underline: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                height: 2,
                                color: Colors.grey,
                              ),
                              onChanged: (int newValue) {
                                setState(() {
                                  _region_id = newValue;
                                });
                              },
                              items: regionList
                                  .map<DropdownMenuItem<int>>((dynamic value) {
                                var jj = new JobType(
                                    id: value['id'], name: value['name']);
                                return DropdownMenuItem<int>(
                                  value: jj.id,
                                  child: Text(value['name']),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 20),
                            DropdownButton<int>(
                              isExpanded: true,
                              hint: Text("job_types".tr()),
                              value: _job_type_id,
                              underline: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                height: 2,
                                color: Colors.grey,
                              ),
                              onChanged: (int newValue) {
                                setState(() {
                                  _job_type_id = newValue;
                                });
                              },
                              items: jobTypeList
                                  .map<DropdownMenuItem<int>>((dynamic value) {
                                var jj = new JobType(
                                    id: value['id'], name: value['name']);
                                return DropdownMenuItem<int>(
                                  value: jj.id,
                                  child: Text(value['name']),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 20),
                            DropdownButton<int>(
                              isExpanded: true,
                              hint: Text("vacancy_types".tr()),
                              value: _vacancy_type_id,
                              underline: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                height: 2,
                                color: Colors.grey,
                              ),
                              onChanged: (int newValue) {
                                setState(() {
                                  _vacancy_type_id = newValue;
                                });
                              },
                              items: vacancyTypeList
                                  .map<DropdownMenuItem<int>>((dynamic value) {
                                var jj = new JobType(
                                    id: value['id'], name: value['name']);
                                return DropdownMenuItem<int>(
                                  value: jj.id,
                                  child: Text(value['name']),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 20),
                            DropdownButton<int>(
                              isExpanded: true,
                              hint: Text("busynesses".tr()),
                              value: _busyness_id,
                              underline: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                height: 2,
                                color: Colors.grey,
                              ),
                              onChanged: (int newValue) {
                                setState(() {
                                  _busyness_id = newValue;
                                });
                              },
                              items: busynessList
                                  .map<DropdownMenuItem<int>>((dynamic value) {
                                var jj = new JobType(
                                    id: value['id'], name: value['name']);
                                return DropdownMenuItem<int>(
                                  value: jj.id,
                                  child: Text(value['name']),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 20),
                            DropdownButton<int>(
                              isExpanded: true,
                              hint: Text("schedules".tr()),
                              value: _schedule_id,
                              underline: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                height: 2,
                                color: Colors.grey,
                              ),
                              onChanged: (int newValue) {
                                setState(() {
                                  _schedule_id = newValue;
                                });
                              },
                              items: scheduleList
                                  .map<DropdownMenuItem<int>>((dynamic value) {
                                var jj = new JobType(
                                    id: value['id'], name: value['name']);
                                return DropdownMenuItem<int>(
                                  value: jj.id,
                                  child: Text(value['name']),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 30),

                            /// Sign In button
                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomButton(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.all(10),
                                    color: Colors.grey[200],
                                    textColor: kColorPrimary,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    text: 'cancel'.tr(),
                                  ),
                                  CustomButton(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.all(10),
                                    color: kColorPrimary,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      if (_vacancyAddFormKey.currentState
                                          .validate()) {
                                        // StoreProvider.of<AppState>(context).dispatch(getCompanyVacancies());
                                        // StoreProvider.of<AppState>(context).dispatch(getVacancies());
                                        Vacancy company_vacancy = new Vacancy(
                                          name: _vacancy_name_controller.text,
                                          salary:
                                              _vacancy_salary_controller.text,
                                          description:
                                              _vacancy_description_controller
                                                  .text,
                                          type: _vacancy_type_id.toString(),
                                          busyness: _busyness_id.toString(),
                                          schedule: _busyness_id.toString(),
                                          job_type: _busyness_id.toString(),
                                          region: _region_id.toString(),
                                        );
                                        Vacancy.saveCompanyVacancy(
                                                vacancy: company_vacancy)
                                            .then((value) {
                                          StoreProvider.of<AppState>(context)
                                              .dispatch(getCompanyVacancies());
                                          Navigator.of(context).pop();
                                        });
                                        // clear inputs
                                        _vacancy_name_controller =
                                            TextEditingController();
                                        _vacancy_salary_controller =
                                            TextEditingController();
                                        _vacancy_description_controller =
                                            TextEditingController();
                                        setState(() {
                                          _schedule_id = null;
                                          _busyness_id = null;
                                          _job_type_id = null;
                                          _vacancy_type_id = null;
                                          _region_id = null;
                                        });
                                      }
                                    },
                                    text: 'add'.tr(),
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
        });
  }

  // Variables
  final _pageController = new PageController();
  int _tabCurrentIndex = 0;
  var discoverPage = DiscoverTab();

  // Tab navigation
  void _nextTab(int tabIndex, {is_profile = false}) {
    // Update tab index
    setState(() => _tabCurrentIndex = tabIndex);
    setState(() => is_profile = true);
    // Update page index
//    if(!is_profile)
    _pageController.animateToPage(tabIndex,
        duration: Duration(microseconds: 500), curve: Curves.ease);
  }

  void _nextTab12(int tabIndex) {
    // Update tab index
    setState(() => is_profile = true);
    // Update page index
    _pageController.animateToPage(tabIndex,
        duration: Duration(microseconds: 500), curve: Curves.ease);
  }

  List<Widget> app_bar_titles = [];

  buildSome(BuildContext context) {
    app_bar_titles = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'ishtapp'.tr(),
            style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic),
          ),
          GestureDetector(
            child: CircleButton(
                bgColor: Colors.transparent,
                padding: 12,
                icon: Icon(
                  Prefs.getString(Prefs.USER_TYPE) == 'COMPANY'
                      ? Boxicons.bxs_plus_square
                      : Boxicons.bx_filter,
                  color: Colors.white,
                  size: 35,
                )),
            onTap: () {
              Prefs.getString(Prefs.USER_TYPE) == 'COMPANY'
                  ? openVacancyForm(context)
                  : openFilterDialog(context);
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
          Text('matches'.tr(),
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
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
            'school'.tr(),
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
              _nextTab(4);
              setState(() {
                is_profile = true;
              });
            },
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
                  fontWeight: FontWeight.w600)),
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

  bool is_special = false;
  void handleInitialBuild(VacanciesScreenProps1 props) {
    props.getLikedNumOfVacancies();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VacanciesScreenProps1>(
        converter: (store) => mapStateToProps(store),
        onInitialBuild: (props) => this.handleInitialBuild(props),
        builder: (context, props) {
          int data = props.response;

          return Scaffold(
            backgroundColor: is_profile ? Colors.white : kColorPrimary,
            appBar: is_special
                ? AppBar(
                    automaticallyImplyLeading: false,
                    title: Container(
//          padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
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
                              color:
                                  _tabCurrentIndex == 0 ? kColorPrimary : null,
                            ),
                            title: Text(
                              "vacancies".tr(),
                              style: TextStyle(
                                  color: _tabCurrentIndex == 0
                                      ? kColorPrimary
                                      : null),
                            ))
                        : BottomNavigationBarItem(
                            icon: Icon(
                              Boxicons.bx_search,
                              color:
                                  _tabCurrentIndex == 0 ? kColorPrimary : null,
                            ),
                            title: Text(
                              "search".tr(),
                              style: TextStyle(
                                  color: _tabCurrentIndex == 0
                                      ? kColorPrimary
                                      : Colors.grey),
                            )),
                    Prefs.getString(Prefs.USER_TYPE) == 'COMPANY'
                        ? BottomNavigationBarItem(
                            icon: Icon(
                              Boxicons.bx_folder,
                              color:
                                  _tabCurrentIndex == 1 ? kColorPrimary : null,
                            ),
                            title: Text(
                              "cvs".tr(),
                              style: TextStyle(
                                  color: _tabCurrentIndex == 1
                                      ? kColorPrimary
                                      : Colors.grey),
                            ))
                        : BottomNavigationBarItem(
                            icon: Container(
                              width: 50,
                              height: 30,
                              child: Stack(children: [
                                Positioned(
                                  top: -1.0,
                                  left: 0.0,
                                  right: StoreProvider.of<AppState>(context)
                                              .state
                                              .vacancy
                                              .number_of_likeds ==
                                          null
                                      ? 0.0
                                      : null,
                                  child: Icon(
                                    Boxicons.bx_like,
                                    color: _tabCurrentIndex == 1
                                        ? kColorPrimary
                                        : null,
                                  ),
                                ),
                                StoreProvider.of<AppState>(context)
                                            .state
                                            .vacancy
                                            .number_of_likeds ==
                                        null
                                    ? Container()
                                    : Positioned(
                                        top: 0.0,
                                        right: 0.0,
                                        child: Badge(
                                            text: StoreProvider.of<AppState>(
                                                            context)
                                                        .state
                                                        .vacancy
                                                        .number_of_likeds ==
                                                    0
                                                ? ''
                                                : StoreProvider.of<AppState>(
                                                        context)
                                                    .state
                                                    .vacancy
                                                    .number_of_likeds
                                                    .toString()),
                                      ),
                              ]),
                            ),
                            title: Text(
                              "matches".tr(),
                              style: TextStyle(
                                  color: _tabCurrentIndex == 1
                                      ? kColorPrimary
                                      : Colors.grey),
                            )),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Boxicons.bx_comment_detail,
                          color: _tabCurrentIndex == 2 ? kColorPrimary : null,
                        ),
                        title: Text(
                          "chat".tr(),
                          style: TextStyle(
                              color: _tabCurrentIndex == 2
                                  ? kColorPrimary
                                  : Colors.grey),
                        )),
                    // BottomNavigationBarItem(
                    //     icon: Icon(
                    //       Boxicons.bx_book,
                    //       color: _tabCurrentIndex == 3 ? kColorPrimary : null,
                    //     ),
                    //     title: Text(
                    //       "school".tr(),
                    //       style: TextStyle(
                    //           color: _tabCurrentIndex == 3
                    //               ? kColorPrimary
                    //               : Colors.grey),
                    //     )),
                  ]),
            ),
            body: WillPopScope(
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    DiscoverTab(),
                    MatchesTab(),
                    ConversationsTab(),
                    // SchoolTab(),
                    ProfileTab(),
                  ],
                ),
                onWillPop: onWillPop),
          );
        });
  }
}

class VacanciesScreenProps1 {
  final Function getLikedNumOfVacancies;
  final int response;

  VacanciesScreenProps1({
    this.getLikedNumOfVacancies,
    this.response,
  });
}

VacanciesScreenProps1 mapStateToProps(Store<AppState> store) {
  return VacanciesScreenProps1(
    response: store.state.vacancy.number_of_likeds,
    getLikedNumOfVacancies: () => store.dispatch(getNumberOfLikedVacancies()),
  );
}
