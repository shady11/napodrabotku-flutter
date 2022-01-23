import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:ishtapp/components/custom_button.dart';
import 'package:ishtapp/constants/configs.dart';
import 'package:ishtapp/datas/pref_manager.dart';
import 'package:ishtapp/datas/user.dart';
import 'package:ishtapp/datas/vacancy.dart';
import 'package:ishtapp/routes/routes.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/widgets/svg_icon.dart';
import 'package:path/path.dart';

enum is_company { Company, User }
enum user_gender { Male, Female }

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Variables
  final _formKey = GlobalKey<FormState>();
  final _username_controller = TextEditingController();
  final _name_controller = TextEditingController();
  final _address_controller = TextEditingController();
  final _contact_person_full_name_controller = TextEditingController();
  final _contact_person_position_controller = TextEditingController();
  final _surnname_controller = TextEditingController();
  final _email_controller = TextEditingController();
  final _linkedin_controller = TextEditingController();
  final _ageFromController = TextEditingController();
  final _ageToController = TextEditingController();

  // final _phone_number_controller = TextEditingController(text: '+(996)');
  final _password_controller = TextEditingController();
  final _password_confirm_controller = TextEditingController();
  final _birth_date_controller = TextEditingController();
  bool _obscureText = true;

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;
  String _retrieveDataError;
  String _birth_date;
  bool isValid = false;
  bool isUserExists = false;

  final TextEditingController _phone_number_controller = TextEditingController();
  String initialCountry = 'KG';
  PhoneNumber number = PhoneNumber(isoCode: 'KG');

  is_company company = is_company.User;
  bool is_sending = false;
  bool is_migrant = false;

  user_gender gender = user_gender.Male;

  void _showDataPicker(context) {
    var date = DateTime.now();
    DatePicker.showDatePicker(context,
        maxTime: new DateTime(date.year - 18, date.month, date.day),
        locale: Prefs.getString(Prefs.LANGUAGE) == 'ky' ? LocaleType.ky : LocaleType.ru,
        theme: DatePickerTheme(
          headerColor: kColorPrimary,
          cancelStyle: const TextStyle(color: Colors.white, fontSize: 17),
          doneStyle: const TextStyle(color: Colors.white, fontSize: 17),
        ), onConfirm: (date) {
      // Change state
      setState(() {
        _birth_date_controller.text = date.toString().split(" ")[0];
      });
    });
  }

  void _showDialog(context, String message, bool error) {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        child: AlertDialog(
          title: Text(''),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('continue'.tr()),
              onPressed: () {
                Navigator.of(ctx).pop();
                if (!error) Navigator.pushReplacementNamed(context, Routes.home);
              },
            )
          ],
        ),
      ),
    );
  }

  void _openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            content: Container(
                color: Colors.transparent,
                height: 50,
                width: 50,
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(kColorPrimary),
                ))),
          ),
        );
      },
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('from_gallery'.tr()),
                      onTap: () {
                        _onImageButtonPressed(ImageSource.gallery, context: context);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('camera'.tr()),
                    onTap: () {
                      _onImageButtonPressed(ImageSource.camera, context: context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
        );

        setState(() {
          _imageFile = pickedFile;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  List<dynamic> jobTypeList = [];
  List<dynamic> regionList = [];
  List<dynamic> districtList = [];
  List<String> jobTypes = [];
  List spheres = [];
  List departments = [];
  List<String> items = [];
  List<String> districts = [];
  List<String> socialOrientations = [];
  List<String> opportunities = [];
  List<String> opportunityTypes = [];
  List<String> opportunityDurations = [];
  String selectedJobType;
  String selectedDepartment;
  String selectedRegion;
  String selectedDistrict;
  String socialOrientation;
  String opportunity;
  String opportunityType;
  String opportunityDuration;

  //TODO Realize this method getJobTypes
  getJobTypes() async {
    // jobTypeList = await Vacancy.getLists('job_type', null);
    // jobTypeList.forEach((jobType) {
    //   setState(() {
    //     jobTypes.add(jobType['name']);
    //   });
    // });
    jobTypeList = await getSpheres();
    jobTypeList.forEach((item) {
      setState(() {
        jobTypes.add(item['jobType']);
      });
    });

    // jobTypes = [
    //   'Коммерческий (Commercial)',
    //   'Цифровое и ИТ (Digital)',
    //   'Социальное (Social)',
    //   'Экология (Ecological)',
    //   'Некоммерческие организации(Non Commercial)'
    // ];
  }

  //TODO Realize this method getSpheres
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

  //TODO Realize this method selectDepartments
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

  getRegions() async {
    regionList = await Vacancy.getLists('region', null);
    regionList.forEach((region) {
      setState(() {
        items.add(region['name']);
      });
    });
  }

  //TODO Realize this method
  getDistricts(region) async {
    districts = [];
    districtList = await Vacancy.getLists('districts', region);
    districtList.forEach((district) {
      setState(() {
        districts.add(district['name']);
      });
    });
  }
//TODO Realize this method
  getSocialOrientations() async {
    socialOrientations = [
      "Дружественные к молодежи - готовность нанимать и привлекать молодежь из регионов и старше 14 лет",
      "Дружественны к девушкам и женщинам",
      "Дружественны к людям с инвалидностью"
    ];
  }
//TODO Realize this method
  getOpportunities() async {
    opportunities = [
      "Волонтерство (Volunteering)",
      "Производственная практика/ Стажировки (Internship)",
      "Мероприятие (Event)",
      "Проект (Project)",
      "Клуб (Club)",
      "Стипендия (Stipend)",
      "Программа по обмену (Exchange program)",
      "Наставничество (Mentorship)",
      "Вызов (Challenge)",
      "Конкурс (Contest)",
      "Оплачиваемое внештатное короткое задание (Paid freelance short assignment)",
      "Олимпиады",
      "Вакансия для молодежи",
    ];
  }
//TODO Realize this method
  getOpportunityTypes() async {
    opportunityTypes = [
      "Оплачивается",
      "Не оплачивается",
      "Другой вид вознаграждения",
    ];
  }
//TODO Realize this method
  getOpportunityDurations() async {
    opportunityDurations = [
      "Разовая",
      "1 неделя",
      "1 месяц",
      "2 месяца",
      "3 месяца",
      "постоянная",
      "временная",
    ];
  }

  @override
  void initState() {
    getRegions();
    getJobTypes();
    getSocialOrientations();
    getOpportunities();
    getOpportunityTypes();
    getOpportunityDurations();
    // getDistricts('all');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sign_up_title".tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text("create_account".tr(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            SizedBox(height: 20),

            /// Profile photo
            GestureDetector(
              child: _imageFile == null
                  ? CircleAvatar(
                      backgroundColor: kColorPrimary,
                      radius: 50,
                      child: SvgIcon("assets/icons/camera_icon.svg", width: 40, height: 40, color: Colors.white),
                    )
                  : CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 50,
                      backgroundImage: Image.file(
                        File(_imageFile.path),
                        fit: BoxFit.cover,
                      ).image,
                    ),
              onTap: () {
                _showPicker(context);
              },
            ),
            SizedBox(height: 10),

            SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: is_company.User,
                  groupValue: company,
                  activeColor: Colors.grey,
                  onChanged: (is_company value) {
                    setState(() {
                      company = value;
                    });
                  },
                ),
                Text('employee'.tr(), style: TextStyle(color: Colors.black)),
                Radio(
                  value: is_company.Company,
                  groupValue: company,
                  activeColor: Colors.grey,
                  onChanged: (is_company value) {
                    setState(() {
                      company = value;
                    });
                  },
                ),
                Text('employer'.tr(), style: TextStyle(color: Colors.black)),
              ],
            ),

            /// Form
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text(
                        'email'.tr(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )),
                  TextFormField(
                    controller: _email_controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: (value) {
                      isValid = EmailValidator.validate(_email_controller.text);
                    },
                    validator: (name) {
                      if (name.isEmpty) {
                        return "please_fill_this_field".tr();
                      } else if (!isValid) {
                        return "please_write_valid_email".tr();
                      } else if (isUserExists) {
                        return "this_email_already_registered".tr();
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
                        'password'.tr(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )),
                  TextFormField(
                    obscureText: _obscureText,
                    controller: _password_controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      fillColor: Colors.grey[200],
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (name) {
                      // Basic validation
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
                        'password_confirm'.tr(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )),
                  TextFormField(
                    controller: _password_confirm_controller,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      fillColor: Colors.grey[200],
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (name) {
                      // Basic validation
                      if (name.isEmpty) {
                        return "please_fill_this_field".tr();
                      } else if (_password_confirm_controller.text != _password_controller.text) {
                        return "passwords_dont_satisfy".tr();
                      }
                      return null;
                    },
                  ),

                  //region Название организации

                  company == is_company.Company
                      ? Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Align(
                                widthFactor: 10,
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  company == is_company.Company ? 'organization_name'.tr() : 'name'.tr(),
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                )),
                            TextFormField(
                              controller: _name_controller,
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
                            )
                          ],
                        )
                      : Container(),

                  //endregion

                  SizedBox(height: 20),

                  //region Адрес организации

                  company == is_company.Company
                      ? Align(
                          widthFactor: 10,
                          heightFactor: 1.5,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Адрес организации',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ))
                      : Container(),
                  company == is_company.Company
                      ? TextFormField(
                          controller: _address_controller,
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
                        )
                      : Container(),

                  //endregion

                  //region Name

                  company == is_company.Company
                      ? Container()
                      : Align(
                          widthFactor: 10,
                          heightFactor: 1.5,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'name'.tr(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )),

                  company == is_company.Company
                      ? Container()
                      : TextFormField(
                          controller: _name_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          validator: (name) {
                            // Basic validation
                            if (name.isEmpty && company == is_company.User) {
                              return "please_fill_this_field".tr();
                            }
                            return null;
                          },
                        ),

                  //endregion

                  SizedBox(height: 20),

                  //region Сфера деятельности

                  company == is_company.Company
                      ? Column(
                          children: <Widget>[
                            Align(
                                widthFactor: 10,
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  company == is_company.Company ? 'job_type'.tr() : 'job_type'.tr(),
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                )),
                            DropdownSearch<String>(
                              showSelectedItem: true,
                              items: jobTypes,
                              onChanged: (value) {
                                selectDepartments(value);
                                setState(() {
                                  selectedJobType = value;
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
                              selectedItem: selectedJobType,
                            ),
                            SizedBox(height: 20),
                          ],
                        )
                      : Container(),

                  selectedJobType != null
                      ? Column(
                    children: <Widget>[
                      Align(
                          widthFactor: 10,
                          heightFactor: 1.5,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Выбор отрасли'.tr(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )),
                      DropdownSearch<String>(
                        showSelectedItem: true,
                        items: departments,
                        onChanged: (value) {
                          selectDepartments(value);
                          setState(() {
                            selectedDepartment = value;
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
                        selectedItem: selectedDepartment,
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                      : Container(),

                  //endregion

                  //region Linkedin Profile

                  // company != is_company.Company
                  //     ? Align(
                  //         widthFactor: 10,
                  //         heightFactor: 1.5,
                  //         alignment: Alignment.topLeft,
                  //         child: Text(
                  //           'linkedin_profile'.tr(),
                  //           style: TextStyle(fontSize: 16, color: Colors.black),
                  //         ),
                  //       )
                  //     : Container(),
                  // company != is_company.Company
                  //     ? TextFormField(
                  //         controller: _linkedin_controller,
                  //         decoration: InputDecoration(
                  //           border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10),
                  //               borderSide: BorderSide.none),
                  //           floatingLabelBehavior: FloatingLabelBehavior.always,
                  //           filled: true,
                  //           fillColor: Colors.grey[200],
                  //         ),
                  //         validator: (name) {
                  //           return null;
                  //         },
                  //       )
                  //     : Container(),

                  //endregion

                  //region Работа за границей

                  // company != is_company.Company
                  //     ? CheckboxListTile(
                  //         title: Text(
                  //           'are_you_migrant'.tr(),
                  //           style: TextStyle(fontSize: 16, color: Colors.black),
                  //         ),
                  //         controlAffinity: ListTileControlAffinity.leading,
                  //         value: is_migrant,
                  //         onChanged: (value) {
                  //           setState(() {
                  //             is_migrant = value;
                  //           });
                  //         },
                  //       )
                  //     : Container(),
                  //
                  // SizedBox(height: 20),

                  //endregion

                  //region Область

                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text(
                        'region'.tr(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )),
                  DropdownSearch<String>(
                      showSelectedItem: true,
                      items: items,
                      onChanged: (value) {
                        setState(() {
                          selectedRegion = value;
                          getDistricts(value);
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
                      selectedItem: selectedRegion),

                  //endregion

                  SizedBox(height: 20),

                  //region Район

                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text(
                        'district'.tr(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )),
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
                  ),

                  //endregion

                  SizedBox(height: 20),

                  //region Социально-ориентированность

                  company == is_company.Company
                      ? Column(
                          children: <Widget>[
                            Align(
                              widthFactor: 10,
                              heightFactor: 1.5,
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Социально-ориентированность',
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ),
                            DropdownSearch<String>(
                              mode: Mode.MENU,
                              showSelectedItem: true,
                              items: socialOrientations,
                              onChanged: (value) {
                                setState(() {
                                  socialOrientation = value;
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
                              selectedItem: socialOrientation,
                            ),
                          ],
                        )
                      : Container(),

                  //endregion

                  //region Выбор возможностей

                  company == is_company.Company
                      ? Column(
                          children: <Widget>[
                            SizedBox(height: 20),
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

                  //endregion

                  //region Описание стажировки

                  /// Вид возможности:
                  company == is_company.Company
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

                  /// Продолжительность возможности - возможность указать срок -
                  company == is_company.Company
                      ? Column(
                          children: <Widget>[
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
                  company == is_company.Company
                      ? Align(
                          widthFactor: 10,
                          heightFactor: 1.5,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Возраст, для которого предназначена возможность',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ))
                      : Container(),
                  company == is_company.Company
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

                  //endregion

                  //region ФИО Контактного лица

                  company == is_company.Company
                      ? Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Align(
                                widthFactor: 10,
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'ФИО Контактного лица',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                )),
                            TextFormField(
                              controller: _contact_person_full_name_controller,
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
                            SizedBox(height: 20),
                          ],
                        )
                      : Container(),

                  //endregion

                  //region Должность контактного лица

                  company == is_company.Company
                      ? Column(
                          children: <Widget>[
                            Align(
                                widthFactor: 10,
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Должность контактного лица',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                )),
                            TextFormField(
                              controller: _contact_person_position_controller,
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
                            SizedBox(height: 20),
                          ],
                        )
                      : Container(),

                  //endregion

                  //region Номер телефона

                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text(
                        'phone_number'.tr(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: InternationalPhoneNumberInput(
                      countries: ['KG', 'RU', 'KZ', 'UA'],
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: true,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: _phone_number_controller,
                      formatInput: false,
                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                      inputDecoration: InputDecoration(
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      locale: 'ru',
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),

                  //endregion

                  //region Дата рождения

                  company == is_company.Company
                      ? Container()
                      : Align(
                          widthFactor: 10,
                          heightFactor: 1.5,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'birth_date'.tr(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )),

                  company == is_company.Company
                      ? Container()
                      : CustomButton(
                          mainAxisAlignment: MainAxisAlignment.start,
                          width: MediaQuery.of(context).size.width * 1,
                          color: Colors.grey[200],
                          textColor: kColorPrimary,
                          textSize: 16,
                          height: 60.0,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.right,
                          text: _birth_date_controller.text,
                          onPressed: () {
                            _showDataPicker(context);
                          }),

                  //endregion

                  SizedBox(height: 20),

                  //region Пол

                  company == is_company.Company
                      ? Container()
                      : Row(children: [
                          Text(
                            'gender'.tr(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ]),

                  company == is_company.Company
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              value: user_gender.Male,
                              groupValue: gender,
                              activeColor: Colors.grey,
                              onChanged: (user_gender value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                            Text('male'.tr(), style: TextStyle(color: Colors.black)),
                            Radio(
                              value: user_gender.Female,
                              groupValue: gender,
                              activeColor: Colors.grey,
                              onChanged: (user_gender value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                            Text('female'.tr(), style: TextStyle(color: Colors.black)),
                          ],
                        ),

                  //endregion

                  SizedBox(height: 40),

                  /// Sign Up button
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      padding: EdgeInsets.all(10),
                      height: 60.0,
                      color: kColorPrimary,
                      textColor: Colors.white,
                      onPressed: () async {
                        User.checkUsername(_email_controller.text).then((value) {
                          setState(() {
                            isUserExists = value;
                          });
                        });

                        /// Validate form
                        if (_formKey.currentState.validate()) {
//                           Navigator.of(context)
//                               .popUntil((route) => route.isFirst);
                          _openLoadingDialog(context);
                          final DateFormat formatter = DateFormat('yyyy-MM-dd');

                          User user = new User();
                          user.password = _password_controller.text;
                          user.email = _email_controller.text;
                          user.phone_number = _phone_number_controller.text;
                          user.birth_date = company == is_company.Company
                              ? DateTime.now()
                              : formatter.parse(_birth_date_controller.text);
                          user.name = _name_controller.text;
                          user.surname = _surnname_controller.text;
                          user.is_company = company == is_company.Company;
                          user.is_migrant = is_migrant ? 1 : 0;
                          user.linkedin = _linkedin_controller.text;
                          user.gender = gender == user_gender.Male ? 0 : 1;
                          user.region = selectedRegion;
                          user.district = selectedDistrict;
                          user.job_type = selectedJobType;

                          var uri = Uri.parse(API_IP + API_REGISTER1 + '?lang=' + Prefs.getString(Prefs.LANGUAGE));

                          // create multipart request
                          var request = new http.MultipartRequest("POST", uri);

                          // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request
                          request.fields["id"] = user.id.toString();
                          request.fields["password"] = user.password;
                          request.fields["name"] = user.name;
                          request.fields["lastname"] = user.surname;
                          request.fields["email"] = user.email;
                          request.fields["birth_date"] = formatter.format(user.birth_date);
                          request.fields["active"] = '1';
                          request.fields["phone_number"] = user.phone_number;
                          request.fields["type"] = user.is_company ? 'COMPANY' : 'USER';
                          request.fields["linkedin"] = user.linkedin;
                          request.fields["is_migrant"] = user.is_migrant.toString();
                          request.fields["gender"] = user.gender.toString();
                          request.fields["region"] = user.region.toString();
                          request.fields["district"] = user.district.toString();
                          request.fields["job_type"] = user.job_type.toString();

                          // open a byteStream
                          if (_imageFile != null) {
                            var _image = File(_imageFile.path);
                            var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
                            // get file length
                            var length = await _image.length();
                            // multipart that takes file.. here this "image_file" is a key of the API request
                            var multipartFile =
                                new http.MultipartFile('avatar', stream, length, filename: basename(_image.path));
                            // add file to multipart
                            request.files.add(multipartFile);
                          }
                          request.send().then((response) {
                            print(response);
                            response.stream.transform(utf8.decoder).listen((value) {
                              print(value);
                              var response = json.decode(value);
                              if (response['status'] == 200) {
                                Prefs.setString(Prefs.PASSWORD, user.password);
                                Prefs.setString(Prefs.TOKEN, response["token"]);
                                Prefs.setString(Prefs.EMAIL, response["email"]);
                                Prefs.setInt(Prefs.USER_ID, response["id"]);
                                Prefs.setString(Prefs.USER_TYPE, user.is_company ? 'COMPANY' : 'USER');
                                Prefs.setString(Prefs.PROFILEIMAGE, response["avatar"]);
                                _showDialog(context, 'successfull_sign_up'.tr(), false);
                              } else {
                                _showDialog(context, 'some_errors_occured_plese_try_again'.tr(), true);
                              }
                            });
                          }).catchError((e) {
                            print(e);
                          });
                        } else {
                          return;
                        }
                      },
                      text: 'create'.tr(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
