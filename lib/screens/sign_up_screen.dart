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
  final _name_controller = TextEditingController();
  final _surnname_controller = TextEditingController();
  final _email_controller = TextEditingController();
  final _linkedin_controller = TextEditingController();
  final _password_controller = TextEditingController();
  final _password_confirm_controller = TextEditingController();
  final _birth_date_controller = TextEditingController();
  final TextEditingController _phone_number_controller = TextEditingController();
  bool _obscureText = true;

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  String _birth_date;
  bool isValid = false;
  bool isUserExists = false;

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
        print(e);
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
      print(response.exception.code);
    }
  }

  List<dynamic> regionList = [];
  List<dynamic> districtList = [];
  List spheres = [];
  List<String> items = [];
  List<String> districts = [];
  String selectedRegion;
  String selectedDistrict;

  getRegions() async {
    regionList = await Vacancy.getLists('region', null);
    regionList.forEach((region) {
      setState(() {
        items.add(region['name']);
      });
    });
  }

  getDistricts(region) async {
    districts = [];
    districtList = await Vacancy.getLists('districts', region);
    districtList.forEach((district) {
      setState(() {
        districts.add(district['name']);
      });
    });
  }

  setMode() {
    setState(() {
      company = Prefs.getString(Prefs.ROUTE) == "COMPANY" ? is_company.Company : is_company.User;
    });
  }

  @override
  void initState() {
    setMode();
    getRegions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sign_up_title".tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "create_account".tr(),
                  style: TextStyle(
                      fontSize: 24,
                      color: kColorDark,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
            ),

            /// Profile photo
            GestureDetector(
              child: _imageFile == null
                  ? CircleAvatar(
                      backgroundColor: kColorGray,
                      radius: 50,
                      child: SvgIcon(
                          "assets/icons/camera_icon.svg",
                          width: 40,
                          height: 40,
                          color: kColorSecondary
                      ),
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

            /// Form
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  /// Название организации
                  company == is_company.Company ?
                  Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      Align(
                          widthFactor: 10,
                          heightFactor: 1.5,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'organization_name'.tr().toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                          )
                      ),
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
                          if (name.isEmpty) {
                            return "please_fill_this_field".tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ) :
                  Container(),

                  /// Контакный Телефон
                  Align(
                      widthFactor: 10,
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text(
                        company == is_company.Company ? 'Контактный телефон'.tr().toString().toUpperCase() : 'phone_number'.tr().toString().toUpperCase(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                        ),
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[200],
                                width: 2.0
                            )
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        filled: true,
                        fillColor: kColorWhite,
                      ),
                      locale: 'ru',
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),

                  /// Электронный адрес
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Align(
                          widthFactor: 10,
                          heightFactor: 1.5,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'email'.tr().toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _email_controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[200],
                                    width: 2.0
                                )
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            filled: true,
                            fillColor: kColorWhite,
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
                      ],
                    ),
                  ),

                  /// Пароль
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Align(
                            widthFactor: 10,
                            heightFactor: 1.5,
                            alignment: Alignment.topLeft,
                            child: Text(
                              'password'.tr().toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                              ),
                            )
                        ),
                        TextFormField(
                          obscureText: _obscureText,
                          controller: _password_controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[200],
                                    width: 2.0
                                )
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            filled: true,
                            fillColor: kColorWhite,
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: kColorSecondary,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          validator: (password) {
                            // Basic validation
                            if (password.isEmpty) {
                              return "please_fill_this_field".tr();
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  /// Подверждение пароли
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Align(
                            widthFactor: 10,
                            heightFactor: 1.5,
                            alignment: Alignment.topLeft,
                            child: Text(
                              'password_confirm'.tr().toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                              ),
                            )
                        ),
                        TextFormField(
                          controller: _password_confirm_controller,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[200],
                                    width: 2.0
                                )
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            filled: true,
                            fillColor: kColorWhite,
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: kColorSecondary,
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
                      ],
                    ),
                  ),

                  /// ФИО user
                  company == is_company.Company ?
                  Container() :
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Align(
                            widthFactor: 10,
                            heightFactor: 1.5,
                            alignment: Alignment.topLeft,
                            child: Text(
                              'name'.tr().toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                              ),
                            )
                        ),
                        TextFormField(
                          controller: _name_controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[200],
                                    width: 2.0
                                )
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            filled: true,
                            fillColor: kColorWhite,
                          ),
                          validator: (name) {
                            // Basic validation
                            if (name.isEmpty && company == is_company.User) {
                              return "please_fill_this_field".tr();
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  /// Область видна только для User
                  company == is_company.Company ?
                  Container() :
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Align(
                            widthFactor: 10,
                            heightFactor: 1.5,
                            alignment: Alignment.topLeft,
                            child: Text(
                              'region'.tr().toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                              ),
                            )
                        ),
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
                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[200],
                                      width: 2.0
                                  )
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              filled: true,
                              fillColor: kColorWhite,
                            ),
                            selectedItem: selectedRegion
                        ),
                      ],
                    ),
                  ),

                  /// Район виден только для User
                  company == is_company.Company ?
                  Container() :
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Align(
                            widthFactor: 10,
                            heightFactor: 1.5,
                            alignment: Alignment.topLeft,
                            child: Text(
                              'district'.tr().toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                              ),
                            )
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
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[200],
                                    width: 2.0
                                )
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            filled: true,
                            fillColor: kColorWhite,
                          ),
                          selectedItem: selectedDistrict,
                        ),
                      ],
                    ),
                  ),

                  /// Дата рождения
                  company == is_company.Company ?
                  Container() :
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Align(
                            widthFactor: 10,
                            heightFactor: 1.5,
                            alignment: Alignment.topLeft,
                            child: Text(
                              'birth_date'.tr().toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                              ),
                            )
                        ),
                        CustomButton(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                            mainAxisAlignment: MainAxisAlignment.start,
                            borderSide: BorderSide(
                                color: Colors.grey[200],
                                width: 2.0
                            ),
                            color: kColorWhite,
                            textColor: kColorPrimary,
                            textAlign: TextAlign.left,
                            fontWeight: FontWeight.w400,
                            text: _birth_date_controller.text,
                            onPressed: () {
                              _showDataPicker(context);
                            }
                        ),
                      ],
                    ),
                  ),

                  /// Пол
                  company == is_company.Company ?
                  Container() :
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Row(
                          children: [
                            Align(
                                widthFactor: 10,
                                heightFactor: 1.5,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'gender'.tr().toString().toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700
                                  ),
                                )
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              value: user_gender.Male,
                              groupValue: gender,
                              activeColor: kColorPrimary,
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
                              activeColor: kColorPrimary,
                              onChanged: (user_gender value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                            Text('female'.tr(), style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// Sign Up button
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      color: kColorPrimary,
                      textColor: Colors.white,
                      onPressed: () async {
                        User.checkUsername(_email_controller.text).then((value) async {

                          setState(() {
                            isUserExists = value;
                          });

                          /// Validate form
                          if (_formKey.currentState.validate()) {
                            _openLoadingDialog(context);
                            final DateFormat formatter = DateFormat('yyyy-MM-dd');

                            User user = new User();
                            user.name = _name_controller.text;
                            user.phone_number = _phone_number_controller.text;
                            user.email = _email_controller.text;
                            user.password = _password_controller.text;
                            user.birth_date = company == is_company.Company
                                ? DateTime.now()
                                : formatter.parse(_birth_date_controller.text);
                            user.surname = _surnname_controller.text;
                            user.is_company = company == is_company.Company;
                            user.is_migrant = is_migrant ? 1 : 0;
                            user.linkedin = _linkedin_controller.text;
                            user.gender = gender == user_gender.Male ? 0 : 1;
                            user.region = selectedRegion;
                            user.district = selectedDistrict;
                            user.is_product_lab_user = Prefs.getString(Prefs.ROUTE) == "PRODUCT_LAB";

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
                            request.fields["is_product_lab_user"] = user.is_product_lab_user ? "1" : "0";

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
                                  _showDialog(context, 'some_error_occurred_plese_try_again'.tr(), true);
                                }
                              });
                            }).catchError((e) {
                              print(e);
                            });
                          } else {
                            return;
                          }

                        });


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
