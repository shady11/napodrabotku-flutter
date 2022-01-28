import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:ishtapp/datas/RSAA.dart';
import 'package:ishtapp/datas/app_state.dart';
import 'package:ishtapp/datas/user.dart';
import 'package:ishtapp/tabs/school_tab.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:ishtapp/widgets/cicle_button.dart';
import 'package:ishtapp/components/custom_button.dart';
import 'package:ishtapp/tabs/conversations_tab.dart';
import 'package:ishtapp/tabs/discover_tab.dart';
import 'package:ishtapp/tabs/matches_tab.dart';
import 'package:ishtapp/tabs/profile_tab.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/datas/vacancy.dart';
import 'package:ishtapp/widgets/badge.dart';
import 'package:ishtapp/datas/pref_manager.dart';
import 'package:ishtapp/utils/textFormatter/lengthLimitingTextInputFormatter.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:email_validator/email_validator.dart';

enum work_mode { isWork, isTraining }

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
  List<dynamic> districtList = [];
  List<dynamic> currencyList = [];

  List<String> regions = [];
  List<String> districts = [];
  List<String> jobs = [];
  List<String> departments = [];
  List<String> socialOrientations = [];
  List<String> opportunities = [];
  List<String> opportunityTypes = [];
  List<String> opportunityDurations = [];
  List<String> internshipLanguageTypes = [];
  List<String> typeOfRecommendedLetters = [];

  List _job_types = [];
  List _vacancy_types = [];
  List _busynesses = [];
  List _schedules = [];
  List _regions = [];
  List _districts = [];
  List _currencies = [];
  List spheres = [];

  String selectedRegion;
  String selectedDistrict;
  String selectedJobType;
  String selectedDepartment;
  String socialOrientation;
  String opportunity;
  String opportunityType;
  String opportunityDuration;
  String selectedInternshipType;
  String selectedTypeOfRecommendedLetter;

  int _job_type_id;
  int _vacancy_type_id;
  int _busyness_id;
  int _schedule_id;
  int _region_id;
  int _district_id;
  int _currency_id;

  work_mode work = work_mode.isWork;

  JobType vacancy_region = new JobType(id: 1, name: 'Бишкек');
  int c = 0;

  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(context, msg: 'click_once_to_exit'.tr());
      return Future.value(false);
    }
    return Future.value(true);
  }

  getLists() async {
    jobTypeList = await Vacancy.getLists('job_type', null);
    vacancyTypeList = await Vacancy.getLists('vacancy_type', null);
    busynessList = await Vacancy.getLists('busyness', null);
    scheduleList = await Vacancy.getLists('schedule', null);
    await Vacancy.getLists('region', null).then((value) {
      value.forEach((region) {
        regions.add(region["name"]);
      });
    });
    // districtList = await Vacancy.getLists('districts', null);
    currencyList = await Vacancy.getLists('currencies', null);
  }

  getFilters(id) async {
    _job_types = await User.getFilters('activities', id);
    _vacancy_types = await User.getFilters('types', id);
    _busynesses = await User.getFilters('busyness', id);
    _schedules = await User.getFilters('schedules', id);
    _regions = await User.getFilters('regions', id);
    // _districts = await User.getFilters('districts', id);
  }

  getDistrictsById(region) async {
    this.districtList = await Vacancy.getDistrictsById('districts', region);
  }

  getDistrictsByRegionName(region) async {
    districtList = await Vacancy.getLists('districts', region);
    districtList.forEach((district) {
      setState(() {
        districts.add(district['name']);
      });
    });
  }

  //TODO Realize this method
  getSpheres() async {
    spheres = [
      {
        "id": 1,
        "jobType": "Коммерческий (Commercial)",
        "departments": ["все бизнес компании"]
      },
      {
        "id": 2,
        "jobType": "Цифровое и ИТ (Digital)",
        "departments": ["все ИТ и стартапы"]
      },
      {
        "id": 3,
        "jobType": "Социальное (Social)",
        "departments": [
          "НПО",
          "МО",
          "Гос. Учреждения",
          "Соц. Проекты и инициативы",
        ]
      },
      {
        "id": 4,
        "jobType": "Экология (Ecological)",
        "departments": [
          "НПО",
          "МО",
          "Гос. Учреждения",
          "Экологические проекты и инициативы",
        ]
      },
      {
        "id": 5,
        "jobType": "Некоммерческие организации",
        "departments": [
          "Test1",
          "Test1",
          "Test1",
          "Test1",
        ]
      }
    ];
    return spheres;
  }

  getJobs() async {
    spheres = [
      {
        "id": 1,
        "jobType": "Коммерческий (Commercial)",
        "departments": ["все бизнес компании"]
      },
      {
        "id": 2,
        "jobType": "Цифровое и ИТ (Digital)",
        "departments": ["все ИТ и стартапы"]
      },
      {
        "id": 3,
        "jobType": "Социальное (Social)",
        "departments": [
          "НПО",
          "МО",
          "Гос. Учреждения",
          "Соц. Проекты и инициативы",
        ]
      },
      {
        "id": 4,
        "jobType": "Экология (Ecological)",
        "departments": [
          "НПО",
          "МО",
          "Гос. Учреждения",
          "Экологические проекты и инициативы",
        ]
      },
      {
        "id": 5,
        "jobType": "Некоммерческие организации",
        "departments": [
          "Test1",
          "Test1",
          "Test1",
          "Test1",
        ]
      }
    ];

    spheres.forEach((item) {
      setState(() {
        jobs.add(item['jobType']);
      });
    });
  }

  getOpportunities() async {
    var list = await Vacancy.getLists('opportunity', null);
    list.forEach((item) {
      setState(() {
        opportunities.add(item["name"]);
      });
    });
  }

  getOpportunityTypes() async {
    var list = await Vacancy.getLists('opportunity_type', null);
    list.forEach((item) {
      setState(() {
        opportunityTypes.add(item["name"]);
      });
    });
  }

  getOpportunityDurations() async {
    var list = await Vacancy.getLists('opportunity_duration', null);
    list.forEach((item) {
      setState(() {
        opportunityDurations.add(item["name"]);
      });
    });
  }

  getInternshipLanguages() async {
    var list = await Vacancy.getLists('intership_language', null);
    list.forEach((item) {
      setState(() {
        internshipLanguageTypes.add(item["name"]);
      });
    });
  }

  getRecommendationLetterType() async {
    var list = await Vacancy.getLists('recommendation_letter_type', null);
    list.forEach((item) {
      setState(() {
        typeOfRecommendedLetters.add(item["name"]);
      });
    });
  }

  selectDepartments(String jobType) {
    setState(() {
      selectedDepartment = null;
    });
    spheres.forEach((item) {
      if (item["jobType"] == jobType) {
        setState(() {
          departments = item["departments"];
        });
      }
    });
  }

  TextEditingController _vacancy_name_controller = TextEditingController();
  TextEditingController _vacancy_salary_controller = TextEditingController();
  TextEditingController _vacancy_salary_from_controller = TextEditingController();
  TextEditingController _vacancy_salary_to_controller = TextEditingController();
  TextEditingController _vacancy_description_controller = TextEditingController();
  TextEditingController _ageFromController = TextEditingController();
  TextEditingController _ageToController = TextEditingController();
  TextEditingController _contact_person_full_name_controller = TextEditingController();
  TextEditingController _contact_person_position_controller = TextEditingController();
  TextEditingController _name_controller = TextEditingController();
  TextEditingController _address_controller = TextEditingController();
  TextEditingController _phone_number_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();

  PhoneNumber number = PhoneNumber(isoCode: 'KG');

  bool isValid = false;
  bool is_disability_person_vacancy = false;
  bool salary_by_agreement;

  User user;

  Future<void> openFilterDialog(context) async {
    user = StoreProvider.of<AppState>(context).state.user.user.data;

    if (user != null) {
      getFilters(user.id);
    }

    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            'search_filter'.tr(),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
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
                                'district'.tr(),
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              validator: (value) {
                                if (value == null || value.length == 0) {
                                  return 'select_one_or_more'.tr();
                                }
                                return '';
                              },
                              dataSource: districtList,
                              textField: 'name',
                              valueField: 'id',
                              okButtonLabel: 'ok'.tr(),
                              cancelButtonLabel: 'cancel'.tr(),
                              // required: true,
                              hintWidget: Text('select_one_or_more'.tr()),
                              initialValue: _districts,
                              onSaved: (value) {
                                if (value == null) return;
                                setState(() {
                                  _districts = value;
                                });
                              },
                            ),
//                          SizedBox(height: 20),
                            MultiSelectFormField(
                              autovalidate: false,
                              title: Text(
                                'job_types'.tr(),
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
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
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
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
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
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
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
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

                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  CustomButton(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.all(10),
                                    color: Colors.grey[200],
                                    textColor: kColorPrimary,
                                    onPressed: () {
                                      setState(() {
                                        _region_id = null;
                                        _regions = [];
                                        _districts = [];
                                        _job_types = [];
                                        _vacancy_types = [];
                                        _busynesses = [];
                                        _schedules = [];
                                      });

                                      if (user != null) {
                                        user.saveFilters(
                                            _regions, _districts, _job_types, _vacancy_types, _busynesses, _schedules);
                                      }

                                      StoreProvider.of<AppState>(context).dispatch(setFilter(
                                          schedule_ids: _schedules,
                                          busyness_ids: _busynesses,
                                          region_ids: [_region_id],
                                          district_ids: _districts,
                                          vacancy_type_ids: _vacancy_types,
                                          job_type_ids: _job_types));

                                      StoreProvider.of<AppState>(context).dispatch(getVacancies());

                                      Navigator.of(context).pop();
                                      _nextTab(0);
                                    },
                                    text: 'change'.tr(),
                                  ),
                                  CustomButton(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.all(10),
                                    color: kColorPrimary,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      if (user != null) {
                                        user.saveFilters(
                                            _regions, _districts, _job_types, _vacancy_types, _busynesses, _schedules);
                                      }
                                      StoreProvider.of<AppState>(context).dispatch(setFilter(
                                          schedule_ids: _schedules,
                                          busyness_ids: _busynesses,
                                          region_ids: [_region_id],
                                          district_ids: _districts,
                                          vacancy_type_ids: _vacancy_types,
                                          job_type_ids: _job_types));
                                      StoreProvider.of<AppState>(context).dispatch(getVacancies());
                                      Navigator.of(context).pop();
                                      _nextTab(0);
                                    },
                                    text: 'save'.tr(),
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

  Future<void> openVacancyForm(context) async {
    _job_type_id = null;
    _vacancy_type_id = null;
    _busyness_id = null;
    _schedule_id = null;
    _region_id = null;
    _district_id = null;
    _currency_id = null;

    salary_by_agreement = false;
    print(salary_by_agreement);

    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            'add'.tr(),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                value: work_mode.isWork,
                                groupValue: work,
                                activeColor: Colors.grey,
                                onChanged: (work_mode value) {
                                  setState(() {
                                    work = value;
                                  });
                                },
                              ),
                              Text('Работа '.tr(), style: TextStyle(color: Colors.black)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                value: work_mode.isTraining,
                                groupValue: work,
                                activeColor: Colors.grey,
                                onChanged: (work_mode value) {
                                  setState(() {
                                    work = value;
                                  });
                                },
                              ),
                              Text('Повышение квалификации'.tr(), style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'fill_all_fields'.tr(),
                            style: TextStyle(fontSize: 14, color: kColorPrimary),
                          )),
                      SizedBox(
                        height: 30,
                      ),

                      /// Form
                      Form(
                        key: _vacancyAddFormKey,
                        child: Column(
                          children: <Widget>[
                            /// Выбор возможностей
                            work == work_mode.isTraining
                                ? Column(
                                    children: <Widget>[
                                      Align(
                                        widthFactor: 10,
                                        heightFactor: 1.5,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Выбор возможностей',
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ),
                                      DropdownSearch<String>(
                                        showSelectedItem: true,
                                        items: opportunities,
                                        onChanged: (value) {
                                          setState(() {
                                            opportunity = value;
                                          });
                                        },
                                        dropdownSearchDecoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
                                        selectedItem: opportunity,
                                      ),
                                    ],
                                  )
                                : Container(),

                            /// Вид возможности
                            work == work_mode.isTraining
                                ? Column(
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Align(
                                        widthFactor: 10,
                                        heightFactor: 1.5,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Вид возможности',
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ),
                                      DropdownSearch<String>(
                                        mode: Mode.MENU,
                                        showSelectedItem: true,
                                        items: opportunityTypes,
                                        onChanged: (value) {
                                          setState(() {
                                            opportunityType = value;
                                          });
                                        },
                                        dropdownSearchDecoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
                                        selectedItem: opportunityType,
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  )
                                : Container(),

                            /// Язык для стажировки
                            work == work_mode.isTraining
                                ? Column(
                                    children: <Widget>[
                                      Align(
                                        widthFactor: 10,
                                        heightFactor: 1.5,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Язык для стажировки',
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ),
                                      DropdownSearch<String>(
                                        mode: Mode.MENU,
                                        showSelectedItem: true,
                                        items: internshipLanguageTypes,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedInternshipType = value;
                                          });
                                        },
                                        dropdownSearchDecoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
                                        selectedItem: selectedInternshipType,
                                      ),
                                    ],
                                  )
                                : Container(),

                            /// Продолжительность возможности
                            work == work_mode.isTraining
                                ? Column(
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Align(
                                        widthFactor: 10,
                                        heightFactor: 1.5,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Продолжительность возможности',
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ),
                                      DropdownSearch<String>(
                                        showSelectedItem: true,
                                        items: opportunityDurations,
                                        onChanged: (value) {
                                          setState(() {
                                            opportunityDuration = value;
                                          });
                                        },
                                        dropdownSearchDecoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
                                        selectedItem: opportunityDuration,
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  )
                                : Container(),

                            /// Возраст, для которого предназначена возможность
                            work == work_mode.isTraining
                                ? Align(
                                    widthFactor: 10,
                                    heightFactor: 1.5,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Возраст, для которого предназначена возможность',
                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                    ))
                                : Container(),
                            work == work_mode.isTraining
                                ? Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          'От',
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: 60,
                                          child: TextFormField(
                                            controller: _ageFromController,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                            ],
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                            ),
                                            validator: (name) {
                                              // Basic validation
                                              if (name.isEmpty) {
                                                return "please_fill_this_field".tr();
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          'До',
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: 60,
                                          child: TextFormField(
                                            controller: _ageToController,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                            ],
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                            ),
                                            validator: (name) {
                                              // Basic validation
                                              if (name.isEmpty) {
                                                return "please_fill_this_field".tr();
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),

                            /// Выбор скиллсетов для возможности
                            work == work_mode.isTraining
                                ? Column(
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Align(
                                        widthFactor: 10,
                                        heightFactor: 1.5,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Требуется до',
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ),
                                      // DropdownSearch<String>(
                                      //   showSelectedItem: true,
                                      //   items: typeOfRecommendedLetters,
                                      //   onChanged: (value) {
                                      //     setState(() {
                                      //       selectedTypeOfRecommendedLetter = value;
                                      //     });
                                      //   },
                                      //   dropdownSearchDecoration: InputDecoration(
                                      //       border: OutlineInputBorder(
                                      //         borderRadius: BorderRadius.circular(10),
                                      //         borderSide: BorderSide.none,
                                      //       ),
                                      //       filled: true,
                                      //       fillColor: Colors.grey[200],
                                      //       contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
                                      //   selectedItem: selectedTypeOfRecommendedLetter,
                                      // ),
                                      SizedBox(height: 20),
                                    ],
                                  )
                                : Container(),
                            work == work_mode.isTraining
                                ? Column(
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Align(
                                        widthFactor: 10,
                                        heightFactor: 1.5,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Могут развить',
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ),
                                      // DropdownSearch<String>(
                                      //   showSelectedItem: true,
                                      //   items: typeOfRecommendedLetters,
                                      //   onChanged: (value) {
                                      //     setState(() {
                                      //       selectedTypeOfRecommendedLetter = value;
                                      //     });
                                      //   },
                                      //   dropdownSearchDecoration: InputDecoration(
                                      //       border: OutlineInputBorder(
                                      //         borderRadius: BorderRadius.circular(10),
                                      //         borderSide: BorderSide.none,
                                      //       ),
                                      //       filled: true,
                                      //       fillColor: Colors.grey[200],
                                      //       contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
                                      //   selectedItem: selectedTypeOfRecommendedLetter,
                                      // ),
                                      SizedBox(height: 20),
                                    ],
                                  )
                                : Container(),

                            /// Готовность выдать рекомендательное письмо
                            work == work_mode.isTraining
                                ? Column(
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Align(
                                        widthFactor: 10,
                                        heightFactor: 1.5,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Готовность выдать рекомендательное письмо',
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ),
                                      DropdownSearch<String>(
                                        showSelectedItem: true,
                                        items: typeOfRecommendedLetters,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTypeOfRecommendedLetter = value;
                                          });
                                        },
                                        dropdownSearchDecoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
                                        selectedItem: selectedTypeOfRecommendedLetter,
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  )
                                : Container(),

                            /// Название вакансии
                            work_mode.isWork == work
                                ? Column(
                                    children: [
                                      Align(
                                          widthFactor: 10,
                                          heightFactor: 1.5,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'vacancy_name'.tr(),
                                            style: TextStyle(fontSize: 16, color: Colors.black),
                                          )),
                                      TextFormField(
                                        controller: _vacancy_name_controller,
                                        focusNode: FocusNode(canRequestFocus: false),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                    ],
                                  )
                                : Container(),

                            /// Salary
                            work == work_mode.isWork
                                ? Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Align(
                                          widthFactor: 10,
                                          heightFactor: 1.5,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'vacancy_salary'.tr(),
                                            style: TextStyle(fontSize: 16, color: Colors.black),
                                          )),
                                      salary_by_agreement
                                          ? DropdownButtonFormField<int>(
                                              hint: Text("currency".tr()),
                                              value: _currency_id,
                                              onChanged: (int newValue) async {
                                                await getDistrictsById(newValue);
                                                setState(() {
                                                  _currency_id = newValue;
                                                });
                                              },
                                              focusNode: FocusNode(canRequestFocus: false),
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey),
                                                ),
                                              ),
                                              items: currencyList.map<DropdownMenuItem<int>>((dynamic value) {
                                                var jj = new JobType(id: value['id'], name: value['name']);
                                                return DropdownMenuItem<int>(
                                                  value: jj.id,
                                                  child: Text(value['name']),
                                                );
                                              }).toList(),
                                            )
                                          : DropdownButtonFormField<int>(
                                              hint: Text("currency".tr()),
                                              value: _currency_id,
                                              onChanged: (int newValue) async {
                                                await getDistrictsById(newValue);
                                                setState(() {
                                                  _currency_id = newValue;
                                                });
                                              },
                                              focusNode: FocusNode(canRequestFocus: false),
                                              validator: (value) =>
                                                  value == null ? "please_fill_this_field".tr() : null,
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey),
                                                ),
                                              ),
                                              items: currencyList.map<DropdownMenuItem<int>>((dynamic value) {
                                                var jj = new JobType(id: value['id'], name: value['name']);
                                                return DropdownMenuItem<int>(
                                                  value: jj.id,
                                                  child: Text(value['name']),
                                                );
                                              }).toList(),
                                            ),
                                      SizedBox(height: 20),
                                      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                        Expanded(
                                          // optional flex property if flex is 1 because the default flex is 1
                                          flex: 1,
                                          child: salary_by_agreement
                                              ? TextFormField(
                                                  enabled: false,
                                                  controller: _vacancy_salary_from_controller,
                                                  focusNode: FocusNode(canRequestFocus: false),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        borderSide: BorderSide.none),
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                  ),
                                                  inputFormatters: [Utf8LengthLimitingTextInputFormatter(20)],
                                                  validator: (name) {
                                                    return null;
                                                  },
                                                )
                                              : TextFormField(
                                                  controller: _vacancy_salary_from_controller,
                                                  focusNode: FocusNode(canRequestFocus: false),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        borderSide: BorderSide.none),
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                  ),
                                                  inputFormatters: [Utf8LengthLimitingTextInputFormatter(20)],
                                                  validator: (name) {
                                                    if (name.isEmpty) {
                                                      return "please_fill_this_field".tr();
                                                    }
                                                    return null;
                                                  },
                                                ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Text('__'),
                                        ),
                                        Expanded(
                                          // optional flex property if flex is 1 because the default flex is 1
                                          flex: 1,
                                          child: salary_by_agreement
                                              ? TextFormField(
                                                  enabled: false,
                                                  controller: _vacancy_salary_to_controller,
                                                  focusNode: FocusNode(canRequestFocus: false),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        borderSide: BorderSide.none),
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                  ),
                                                  inputFormatters: [Utf8LengthLimitingTextInputFormatter(20)],
                                                  validator: (name) {
                                                    return null;
                                                  },
                                                )
                                              : TextFormField(
                                                  controller: _vacancy_salary_to_controller,
                                                  focusNode: FocusNode(canRequestFocus: false),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        borderSide: BorderSide.none),
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                  ),
                                                  inputFormatters: [Utf8LengthLimitingTextInputFormatter(20)],
                                                  validator: (name) {
                                                    if (name.isEmpty) {
                                                      return "please_fill_this_field".tr();
                                                    }
                                                    return null;
                                                  },
                                                ),
                                        ),
                                      ]),
                                      SizedBox(height: 20),
                                      CustomButton(
                                        width: MediaQuery.of(context).size.width * 1,
                                        padding: EdgeInsets.all(10),
                                        color: salary_by_agreement ? kColorPrimary : Colors.grey[200],
                                        textColor: salary_by_agreement ? Colors.white : kColorPrimary,
                                        onPressed: () {
                                          setState(() {
                                            salary_by_agreement = !salary_by_agreement;
                                          });
                                          salary_by_agreement
                                              ? _vacancy_salary_controller.text = 'По договоренности'
                                              : TextEditingController();
                                        },
                                        text: 'by_agreement'.tr(),
                                      ),
                                    ],
                                  )
                                : Container(),

                            work == work_mode.isTraining
                                ? Container()
                                : Column(
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Align(
                                          widthFactor: 10,
                                          heightFactor: 1.5,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'vacancy_description'.tr(),
                                            style: TextStyle(fontSize: 16, color: Colors.black),
                                          )),
                                      TextFormField(
                                        controller: _vacancy_description_controller,
                                        maxLines: 5,
                                        focusNode: FocusNode(canRequestFocus: false),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                    ],
                                  ),

                            /// Область
                            work == work_mode.isWork
                                ? Column(
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Align(
                                        widthFactor: 10,
                                        heightFactor: 1.5,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Область',
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ),
                                      DropdownSearch<String>(
                                        showSelectedItem: true,
                                        items: regions,
                                        onChanged: (value) {
                                          getDistrictsByRegionName(value);
                                          setState(() {
                                            selectedRegion = value;
                                          });
                                        },
                                        dropdownSearchDecoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
                                        selectedItem: selectedRegion,
                                      )
                                    ],
                                  )
                                : Container(),
                            SizedBox(height: 20),

                            /// Район
                            work == work_mode.isWork
                                ? Column(
                                    children: <Widget>[
                                      Align(
                                        widthFactor: 10,
                                        heightFactor: 1.5,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Район',
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ),
                                      DropdownSearch<String>(
                                        showSelectedItem: true,
                                        items: districts,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedDistrict = value;
                                          });
                                        },
                                        dropdownSearchDecoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
                                        selectedItem: selectedDistrict,
                                      )
                                    ],
                                  )
                                : Container(),

                            /// Сферы деятельности ishtapp
                            work == work_mode.isWork
                                ? Column(
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      DropdownButtonFormField<int>(
                                        isExpanded: true,
                                        hint: Text("job_types".tr()),
                                        value: _job_type_id,
                                        onChanged: (int newValue) {
                                          setState(() {
                                            _job_type_id = newValue;
                                          });
                                        },
                                        focusNode: FocusNode(canRequestFocus: false),
                                        validator: (value) => value == null ? "please_fill_this_field".tr() : null,
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        items: jobTypeList.map<DropdownMenuItem<int>>((dynamic value) {
                                          var jj = new JobType(id: value['id'], name: value['name']);
                                          return DropdownMenuItem<int>(
                                            value: jj.id,
                                            child: Text(value['name']),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(height: 20),
                                      DropdownButtonFormField<int>(
                                        isExpanded: true,
                                        hint: Text("vacancy_types".tr()),
                                        value: _vacancy_type_id,
                                        onChanged: (int newValue) {
                                          setState(() {
                                            _vacancy_type_id = newValue;
                                          });
                                        },
                                        focusNode: FocusNode(canRequestFocus: false),
                                        validator: (value) => value == null ? "please_fill_this_field".tr() : null,
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        items: vacancyTypeList.map<DropdownMenuItem<int>>((dynamic value) {
                                          var jj = new JobType(id: value['id'], name: value['name']);
                                          return DropdownMenuItem<int>(
                                            value: jj.id,
                                            child: Text(value['name']),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(height: 20),
                                      DropdownButtonFormField<int>(
                                        isExpanded: true,
                                        hint: Text("busynesses".tr()),
                                        value: _busyness_id,
                                        onChanged: (int newValue) {
                                          setState(() {
                                            _busyness_id = newValue;
                                          });
                                        },
                                        focusNode: FocusNode(canRequestFocus: false),
                                        validator: (value) => value == null ? "please_fill_this_field".tr() : null,
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        items: busynessList.map<DropdownMenuItem<int>>((dynamic value) {
                                          var jj = new JobType(id: value['id'], name: value['name']);
                                          return DropdownMenuItem<int>(
                                            value: jj.id,
                                            child: Text(value['name']),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(height: 20),
                                      DropdownButtonFormField<int>(
                                        isExpanded: true,
                                        hint: Text("schedules".tr()),
                                        value: _schedule_id,
                                        onChanged: (int newValue) {
                                          setState(() {
                                            _schedule_id = newValue;
                                          });
                                        },
                                        focusNode: FocusNode(canRequestFocus: false),
                                        validator: (value) => value == null ? "please_fill_this_field".tr() : null,
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        items: scheduleList.map<DropdownMenuItem<int>>((dynamic value) {
                                          var jj = new JobType(id: value['id'], name: value['name']);
                                          return DropdownMenuItem<int>(
                                            value: jj.id,
                                            child: Text(value['name']),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  )
                                : Container(),

                            SizedBox(height: 20),
                            work == work_mode.isWork
                                ? CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      'for_disabilities_people'.tr(),
                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                    ),
                                    controlAffinity: ListTileControlAffinity.leading,
                                    value: is_disability_person_vacancy,
                                    onChanged: (value) {
                                      setState(() {
                                        is_disability_person_vacancy = value;
                                      });
                                    },
                                  )
                                : Container(),
                            SizedBox(height: 30),

                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  CustomButton(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.all(10),
                                    color: Colors.grey[200],
                                    textColor: kColorPrimary,
                                    onPressed: () {
                                      setState(() {
                                        _schedule_id = null;
                                        _busyness_id = null;
                                        _job_type_id = null;
                                        _vacancy_type_id = null;
                                        _region_id = null;
                                        _district_id = null;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    text: 'cancel'.tr(),
                                  ),
                                  CustomButton(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.all(10),
                                    color: kColorPrimary,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      if (_vacancyAddFormKey.currentState.validate()) {
                                        Vacancy company_vacancy = new Vacancy(
                                          name: _vacancy_name_controller.text,
                                          salary: _vacancy_salary_controller.text,
                                          salary_from: _vacancy_salary_from_controller.text,
                                          salary_to: _vacancy_salary_to_controller.text,
                                          is_disability_person_vacancy: is_disability_person_vacancy ? 1 : 0,
                                          description: _vacancy_description_controller.text,
                                          type: _vacancy_type_id != null ? _vacancy_type_id.toString() : null,
                                          busyness: _busyness_id != null ? _busyness_id.toString() : null,
                                          schedule: _schedule_id != null ? _schedule_id.toString() : null,
                                          job_type: _job_type_id != null ? _job_type_id.toString() : null,
                                          region: _region_id != null ? _region_id.toString() : null,
                                          district: _district_id != null ? _district_id.toString() : null,
                                          currency: _currency_id != null ? _currency_id.toString() : null,
                                          opportunity: opportunity,
                                          opportunityType: opportunityType,
                                          opportunityDuration: opportunityDuration,
                                          internshipLanguage: selectedInternshipType,
                                          typeOfRecommendedLetter: selectedTypeOfRecommendedLetter,
                                          ageFrom: _ageFromController.text,
                                          ageTo: _ageToController.text,
                                          isProductLabVacancy: work_mode.isTraining == work,
                                        );

                                        Vacancy.saveCompanyVacancy(vacancy: company_vacancy).then((value) {
                                          StoreProvider.of<AppState>(context).dispatch(getCompanyVacancies());
                                          Navigator.of(context).pop();
                                        });

                                        // clear inputs
                                        _vacancy_name_controller = TextEditingController();
                                        _vacancy_salary_controller = TextEditingController();
                                        _vacancy_salary_from_controller = TextEditingController();
                                        _vacancy_salary_to_controller = TextEditingController();
                                        _vacancy_description_controller = TextEditingController();
                                        _ageFromController = TextEditingController();
                                        _ageToController = TextEditingController();
                                        setState(() {
                                          _schedule_id = null;
                                          _busyness_id = null;
                                          _job_type_id = null;
                                          _vacancy_type_id = null;
                                          _region_id = null;
                                          _district_id = null;
                                          _currency_id = null;
                                          opportunity = null;
                                          opportunityType = null;
                                          opportunityDuration = null;
                                          selectedInternshipType = null;
                                          selectedTypeOfRecommendedLetter = null;
                                        });
                                      } else {
                                        print('invalid');
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

  final _pageController = new PageController();
  int _tabCurrentIndex = 0;
  var discoverPage = DiscoverTab();

  // Tab navigation
  void _nextTab(int tabIndex, {is_profile = false}) {
    // Update tab index
    setState(() => _tabCurrentIndex = tabIndex);
    setState(() => is_profile = true);
    // Update page index
    _pageController.animateToPage(tabIndex, duration: Duration(microseconds: 500), curve: Curves.ease);
  }

  void _nextTab12(int tabIndex) {
    // Update tab index
    setState(() => is_profile = true);
    // Update page index
    _pageController.animateToPage(tabIndex, duration: Duration(microseconds: 500), curve: Curves.ease);
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
              Prefs.getString(Prefs.USER_TYPE) == 'COMPANY'
                  ? await openVacancyForm(context)
                  : await openFilterDialog(context);
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
          Text('profile'.tr(), style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w600)),
        ],
      ),
    ];
  }

  bool is_profile = false;

  @override
  void initState() {
    getLists();
    getOpportunities();
    getOpportunityTypes();
    getOpportunityDurations();
    getJobs();
    getRecommendationLetterType();
    getInternshipLanguages();
    super.initState();
    buildSome(context);
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
                                  right: StoreProvider.of<AppState>(context).state.vacancy.number_of_likeds == null
                                      ? 0.0
                                      : null,
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
                          color: _tabCurrentIndex == 3 ? kColorPrimary : null,
                        ),
                        title: Text(
                          "training".tr(),
                          style: TextStyle(color: _tabCurrentIndex == 3 ? kColorPrimary : Colors.grey),
                        )),
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
                    SchoolTab(),
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
