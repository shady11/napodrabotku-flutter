import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishtapp/datas/vacancy.dart';
import 'package:ishtapp/datas/Skill.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:dropdown_search/dropdown_search.dart';

enum work_mode { work, training }

class EditVacancy extends StatefulWidget {
  const EditVacancy({Key key, this.vacancy, this.vacancySkill}) : super(key: key);

  final Vacancy vacancy;
  final List<VacancySkill> vacancySkill;

  @override
  _EditVacancyState createState() => _EditVacancyState();
}

class _EditVacancyState extends State<EditVacancy> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var data = [];
  final _vacancyEditFormKey = GlobalKey<FormState>();
  List<String> opportunities = [];
  work_mode work = work_mode.work;
  String opportunity;

  getOpportunities() async {
    var list = await Vacancy.getLists('opportunity', null);
    list.forEach((item) {
      setState(() {
        opportunities.add(item["name"]);
      });
    });
  }

  void init() {
    opportunity = widget.vacancy.opportunity;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("edit".tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'edit'.tr(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  )),
              SizedBox(
                height: 20,
              ),

              /// Form
              // Form(
              //   key: _vacancyEditFormKey,
              //   child: Column(
              //     children: <Widget>[
              //       /// Выбор возможностей
              //       work == work_mode.training
              //           ? Column(
              //         children: <Widget>[
              //           Align(
              //             widthFactor: 10,
              //             heightFactor: 1.5,
              //             alignment: Alignment.topLeft,
              //             child: Text(
              //               'choice_opportunity_options'.tr(),
              //               style: TextStyle(fontSize: 16, color: Colors.black),
              //             ),
              //           ),
              //           DropdownSearch<String>(
              //             showSelectedItem: true,
              //             items: opportunities,
              //             onChanged: (value) {
              //               setState(() {
              //                 opportunity = value;
              //               });
              //             },
              //             dropdownSearchDecoration: InputDecoration(
              //                 border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(10),
              //                   borderSide: BorderSide.none,
              //                 ),
              //                 filled: true,
              //                 fillColor: Colors.grey[200],
              //                 contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
              //             selectedItem: opportunity,
              //           ),
              //         ],
              //       )
              //           : Container(),
              //
              //       /// Вид возможности
              //       work == work_mode.isTraining
              //           ? Column(
              //         children: <Widget>[
              //           SizedBox(height: 20),
              //           Align(
              //             widthFactor: 10,
              //             heightFactor: 1.5,
              //             alignment: Alignment.topLeft,
              //             child: Text(
              //               'opportunity_type'.tr(),
              //               style: TextStyle(fontSize: 16, color: Colors.black),
              //             ),
              //           ),
              //           DropdownSearch<String>(
              //             mode: Mode.MENU,
              //             showSelectedItem: true,
              //             items: opportunityTypes,
              //             onChanged: (value) {
              //               setState(() {
              //                 opportunityType = value;
              //               });
              //             },
              //             dropdownSearchDecoration: InputDecoration(
              //                 border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(10),
              //                   borderSide: BorderSide.none,
              //                 ),
              //                 filled: true,
              //                 fillColor: Colors.grey[200],
              //                 contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
              //             selectedItem: opportunityType,
              //           ),
              //           SizedBox(height: 20),
              //         ],
              //       )
              //           : Container(),
              //
              //       /// Язык для стажировки
              //       work == work_mode.isTraining
              //           ? Column(
              //         children: <Widget>[
              //           Align(
              //             widthFactor: 10,
              //             heightFactor: 1.5,
              //             alignment: Alignment.topLeft,
              //             child: Text(
              //               'internship_language'.tr(),
              //               style: TextStyle(fontSize: 16, color: Colors.black),
              //             ),
              //           ),
              //           DropdownSearch<String>(
              //             mode: Mode.MENU,
              //             showSelectedItem: true,
              //             items: internshipLanguageTypes,
              //             onChanged: (value) {
              //               setState(() {
              //                 selectedInternshipType = value;
              //               });
              //             },
              //             dropdownSearchDecoration: InputDecoration(
              //                 border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(10),
              //                   borderSide: BorderSide.none,
              //                 ),
              //                 filled: true,
              //                 fillColor: Colors.grey[200],
              //                 contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
              //             selectedItem: selectedInternshipType,
              //           ),
              //         ],
              //       )
              //           : Container(),
              //
              //       /// Продолжительность возможности
              //       work == work_mode.isTraining
              //           ? Column(
              //         children: <Widget>[
              //           SizedBox(height: 20),
              //           Align(
              //             widthFactor: 10,
              //             heightFactor: 1.5,
              //             alignment: Alignment.topLeft,
              //             child: Text(
              //               'opportunity_duration'.tr(),
              //               style: TextStyle(fontSize: 16, color: Colors.black),
              //             ),
              //           ),
              //           DropdownSearch<String>(
              //             showSelectedItem: true,
              //             items: opportunityDurations,
              //             onChanged: (value) {
              //               setState(() {
              //                 opportunityDuration = value;
              //               });
              //             },
              //             dropdownSearchDecoration: InputDecoration(
              //                 border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(10),
              //                   borderSide: BorderSide.none,
              //                 ),
              //                 filled: true,
              //                 fillColor: Colors.grey[200],
              //                 contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
              //             selectedItem: opportunityDuration,
              //           ),
              //           SizedBox(height: 20),
              //         ],
              //       )
              //           : Container(),
              //
              //       /// Возраст, для которого предназначена возможность
              //       work == work_mode.isTraining
              //           ? Align(
              //           widthFactor: 10,
              //           heightFactor: 1.5,
              //           alignment: Alignment.topLeft,
              //           child: Text(
              //             'opportunity_age'.tr(),
              //             style: TextStyle(fontSize: 16, color: Colors.black),
              //           ))
              //           : Container(),
              //       work == work_mode.isTraining
              //           ? Row(
              //         children: <Widget>[
              //           Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 10),
              //             child: Text(
              //               'От',
              //               style: TextStyle(fontSize: 16, color: Colors.black),
              //             ),
              //           ),
              //           Expanded(
              //             child: Container(
              //               width: 60,
              //               child: TextFormField(
              //                 controller: _ageFromController,
              //                 keyboardType: TextInputType.number,
              //                 inputFormatters: <TextInputFormatter>[
              //                   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              //                 ],
              //                 decoration: InputDecoration(
              //                   border: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(10),
              //                       borderSide: BorderSide.none),
              //                   floatingLabelBehavior: FloatingLabelBehavior.always,
              //                   filled: true,
              //                   fillColor: Colors.grey[200],
              //                 ),
              //                 validator: (name) {
              //                   // Basic validation
              //                   if (name.isEmpty) {
              //                     return "please_fill_this_field".tr();
              //                   }
              //                   return null;
              //                 },
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 10),
              //             child: Text(
              //               'До',
              //               style: TextStyle(fontSize: 16, color: Colors.black),
              //             ),
              //           ),
              //           Expanded(
              //             child: Container(
              //               width: 60,
              //               child: TextFormField(
              //                 controller: _ageToController,
              //                 keyboardType: TextInputType.number,
              //                 inputFormatters: <TextInputFormatter>[
              //                   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              //                 ],
              //                 decoration: InputDecoration(
              //                   border: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(10),
              //                       borderSide: BorderSide.none),
              //                   floatingLabelBehavior: FloatingLabelBehavior.always,
              //                   filled: true,
              //                   fillColor: Colors.grey[200],
              //                 ),
              //                 validator: (name) {
              //                   // Basic validation
              //                   if (name.isEmpty) {
              //                     return "please_fill_this_field".tr();
              //                   }
              //                   return null;
              //                 },
              //               ),
              //             ),
              //           ),
              //         ],
              //       )
              //           : Container(),
              //
              //       /// Выбор скиллсетов для возможности
              //       work == work_mode.isTraining
              //           ? Column(
              //         children: <Widget>[
              //           SizedBox(height: 20),
              //           Align(
              //             widthFactor: 10,
              //             heightFactor: 1.5,
              //             alignment: Alignment.topLeft,
              //             child: Text(
              //               'choose_opportunity_skill_sets'.tr(),
              //               style: TextStyle(fontSize: 16, color: Colors.black),
              //             ),
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceAround,
              //             children: <Widget>[
              //               FlatButton(
              //                   color: kColorPrimaryDark,
              //                   onPressed: () => openSkillDialog(context, true),
              //                   child: Text(
              //                     "Требуется",
              //                     style: TextStyle(fontSize: 16, color: Colors.white),
              //                   )),
              //
              //               FlatButton(
              //                   color: kColorPrimaryDark,
              //                   onPressed: () => openSkillDialog(context, false),
              //                   child: Text(
              //                     "Могут развить",
              //                     style: TextStyle(fontSize: 16, color: Colors.white),
              //                   )),
              //
              //             ],
              //           ),
              //           // Column(
              //           //   children: categories,
              //           // )
              //
              //           // MultiSelectFormField(
              //           //   autovalidate: AutovalidateMode.disabled,
              //           //   title: Text(
              //           //     'required_up_to'.tr(),
              //           //     style:
              //           //     TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
              //           //   ),
              //           //   validator: (value) {
              //           //     if (value == null || value.length == 0) {
              //           //       return 'select_one_or_more'.tr();
              //           //     }
              //           //   },
              //           //   dataSource: skillList,
              //           //   textField: 'name',
              //           //   valueField: 'id',
              //           //   okButtonLabel: 'ok'.tr(),
              //           //   cancelButtonLabel: 'cancel'.tr(),
              //           //   // required: true,
              //           //   hintWidget: Text('select_one_or_more'.tr()),
              //           //   initialValue: skills,
              //           //   onSaved: (value) {
              //           //     if (value == null) return;
              //           //     setState(() {
              //           //       skills = value;
              //           //     });
              //           //   },
              //           // ),
              //           // MultiSelectFormField(
              //           //   autovalidate: AutovalidateMode.disabled,
              //           //   title: Text(
              //           //     'can_improve'.tr(),
              //           //     style:
              //           //     TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
              //           //   ),
              //           //   validator: (value) {
              //           //     if (value == null || value.length == 0) {
              //           //       return 'select_one_or_more'.tr();
              //           //     }
              //           //   },
              //           //   dataSource: skillList,
              //           //   textField: 'name',
              //           //   valueField: 'id',
              //           //   okButtonLabel: 'ok'.tr(),
              //           //   cancelButtonLabel: 'cancel'.tr(),
              //           //   // required: true,
              //           //   hintWidget: Text('select_one_or_more'.tr()),
              //           //   initialValue: skills,
              //           //   onSaved: (value) {
              //           //     if (value == null) return;
              //           //     setState(() {
              //           //       skills = value;
              //           //     });
              //           //   },
              //           // ),
              //         ],
              //       )
              //           : Container(),
              //
              //       // /// Готовность выдать рекомендательное письмо
              //       // work == work_mode.isTraining
              //       //     ? Column(
              //       //   children: <Widget>[
              //       //     SizedBox(height: 20),
              //       //     Align(
              //       //       widthFactor: 10,
              //       //       heightFactor: 1.5,
              //       //       alignment: Alignment.topLeft,
              //       //       child: Text(
              //       //         'Готовность выдать рекомендательное письмо',
              //       //         style: TextStyle(fontSize: 16, color: Colors.black),
              //       //       ),
              //       //     ),
              //       //     DropdownSearch<String>(
              //       //       showSelectedItem: true,
              //       //       items: typeOfRecommendedLetters,
              //       //       onChanged: (value) {
              //       //         setState(() {
              //       //           selectedTypeOfRecommendedLetter = value;
              //       //         });
              //       //       },
              //       //       dropdownSearchDecoration: InputDecoration(
              //       //           border: OutlineInputBorder(
              //       //             borderRadius: BorderRadius.circular(10),
              //       //             borderSide: BorderSide.none,
              //       //           ),
              //       //           filled: true,
              //       //           fillColor: Colors.grey[200],
              //       //           contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
              //       //       selectedItem: selectedTypeOfRecommendedLetter,
              //       //     ),
              //       //     SizedBox(height: 20),
              //       //   ],
              //       // )
              //       //     : Container(),
              //       //
              //       // /// Название вакансии
              //       // work_mode.isWork == work
              //       //     ? Column(
              //       //   children: [
              //       //     Align(
              //       //         widthFactor: 10,
              //       //         heightFactor: 1.5,
              //       //         alignment: Alignment.topLeft,
              //       //         child: Text(
              //       //           'vacancy_name'.tr(),
              //       //           style: TextStyle(fontSize: 16, color: Colors.black),
              //       //         )),
              //       //     TextFormField(
              //       //       controller: _vacancy_name_controller,
              //       //       focusNode: FocusNode(canRequestFocus: false),
              //       //       decoration: InputDecoration(
              //       //         border: OutlineInputBorder(
              //       //             borderRadius: BorderRadius.circular(10),
              //       //             borderSide: BorderSide.none),
              //       //         floatingLabelBehavior: FloatingLabelBehavior.always,
              //       //         filled: true,
              //       //         fillColor: Colors.grey[200],
              //       //       ),
              //       //       validator: (name) {
              //       //         if (name.isEmpty) {
              //       //           return "please_fill_this_field".tr();
              //       //         }
              //       //         return null;
              //       //       },
              //       //     ),
              //       //   ],
              //       // )
              //       //     : Container(),
              //       //
              //       // /// Salary
              //       // work == work_mode.isWork
              //       //     ? Column(
              //       //   children: [
              //       //     SizedBox(height: 20),
              //       //     Align(
              //       //         widthFactor: 10,
              //       //         heightFactor: 1.5,
              //       //         alignment: Alignment.topLeft,
              //       //         child: Text(
              //       //           'vacancy_salary'.tr(),
              //       //           style: TextStyle(fontSize: 16, color: Colors.black),
              //       //         )),
              //       //     salary_by_agreement
              //       //         ? DropdownButtonFormField<int>(
              //       //       hint: Text("currency".tr()),
              //       //       value: _currency_id,
              //       //       onChanged: (int newValue) async {
              //       //         await getDistrictsById(newValue);
              //       //         setState(() {
              //       //           _currency_id = newValue;
              //       //         });
              //       //       },
              //       //       focusNode: FocusNode(canRequestFocus: false),
              //       //       decoration: InputDecoration(
              //       //         enabledBorder: UnderlineInputBorder(
              //       //           borderSide: BorderSide(color: Colors.grey),
              //       //         ),
              //       //       ),
              //       //       items: currencyList.map<DropdownMenuItem<int>>((dynamic value) {
              //       //         var jj = new JobType(id: value['id'], name: value['name']);
              //       //         return DropdownMenuItem<int>(
              //       //           value: jj.id,
              //       //           child: Text(value['name']),
              //       //         );
              //       //       }).toList(),
              //       //     )
              //       //         : DropdownButtonFormField<int>(
              //       //       hint: Text("currency".tr()),
              //       //       value: _currency_id,
              //       //       onChanged: (int newValue) async {
              //       //         await getDistrictsById(newValue);
              //       //         setState(() {
              //       //           _currency_id = newValue;
              //       //         });
              //       //       },
              //       //       focusNode: FocusNode(canRequestFocus: false),
              //       //       validator: (value) =>
              //       //       value == null ? "please_fill_this_field".tr() : null,
              //       //       decoration: InputDecoration(
              //       //         enabledBorder: UnderlineInputBorder(
              //       //           borderSide: BorderSide(color: Colors.grey),
              //       //         ),
              //       //       ),
              //       //       items: currencyList.map<DropdownMenuItem<int>>((dynamic value) {
              //       //         var jj = new JobType(id: value['id'], name: value['name']);
              //       //         return DropdownMenuItem<int>(
              //       //           value: jj.id,
              //       //           child: Text(value['name']),
              //       //         );
              //       //       }).toList(),
              //       //     ),
              //       //     SizedBox(height: 20),
              //       //     Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              //       //       Expanded(
              //       //         // optional flex property if flex is 1 because the default flex is 1
              //       //         flex: 1,
              //       //         child: salary_by_agreement
              //       //             ? TextFormField(
              //       //           enabled: false,
              //       //           controller: _vacancy_salary_from_controller,
              //       //           focusNode: FocusNode(canRequestFocus: false),
              //       //           decoration: InputDecoration(
              //       //             border: OutlineInputBorder(
              //       //                 borderRadius: BorderRadius.circular(10),
              //       //                 borderSide: BorderSide.none),
              //       //             floatingLabelBehavior: FloatingLabelBehavior.always,
              //       //             filled: true,
              //       //             fillColor: Colors.grey[200],
              //       //           ),
              //       //           inputFormatters: [Utf8LengthLimitingTextInputFormatter(20)],
              //       //           validator: (name) {
              //       //             return null;
              //       //           },
              //       //         )
              //       //             : TextFormField(
              //       //           controller: _vacancy_salary_from_controller,
              //       //           focusNode: FocusNode(canRequestFocus: false),
              //       //           decoration: InputDecoration(
              //       //             border: OutlineInputBorder(
              //       //                 borderRadius: BorderRadius.circular(10),
              //       //                 borderSide: BorderSide.none),
              //       //             floatingLabelBehavior: FloatingLabelBehavior.always,
              //       //             filled: true,
              //       //             fillColor: Colors.grey[200],
              //       //           ),
              //       //           inputFormatters: [Utf8LengthLimitingTextInputFormatter(20)],
              //       //           validator: (name) {
              //       //             if (name.isEmpty) {
              //       //               return "please_fill_this_field".tr();
              //       //             }
              //       //             return null;
              //       //           },
              //       //         ),
              //       //       ),
              //       //       Container(
              //       //         padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              //       //         child: Text('__'),
              //       //       ),
              //       //       Expanded(
              //       //         // optional flex property if flex is 1 because the default flex is 1
              //       //         flex: 1,
              //       //         child: salary_by_agreement
              //       //             ? TextFormField(
              //       //           enabled: false,
              //       //           controller: _vacancy_salary_to_controller,
              //       //           focusNode: FocusNode(canRequestFocus: false),
              //       //           decoration: InputDecoration(
              //       //             border: OutlineInputBorder(
              //       //                 borderRadius: BorderRadius.circular(10),
              //       //                 borderSide: BorderSide.none),
              //       //             floatingLabelBehavior: FloatingLabelBehavior.always,
              //       //             filled: true,
              //       //             fillColor: Colors.grey[200],
              //       //           ),
              //       //           inputFormatters: [Utf8LengthLimitingTextInputFormatter(20)],
              //       //           validator: (name) {
              //       //             return null;
              //       //           },
              //       //         )
              //       //             : TextFormField(
              //       //           controller: _vacancy_salary_to_controller,
              //       //           focusNode: FocusNode(canRequestFocus: false),
              //       //           decoration: InputDecoration(
              //       //             border: OutlineInputBorder(
              //       //                 borderRadius: BorderRadius.circular(10),
              //       //                 borderSide: BorderSide.none),
              //       //             floatingLabelBehavior: FloatingLabelBehavior.always,
              //       //             filled: true,
              //       //             fillColor: Colors.grey[200],
              //       //           ),
              //       //           inputFormatters: [Utf8LengthLimitingTextInputFormatter(20)],
              //       //           validator: (name) {
              //       //             if (name.isEmpty) {
              //       //               return "please_fill_this_field".tr();
              //       //             }
              //       //             return null;
              //       //           },
              //       //         ),
              //       //       ),
              //       //     ]),
              //       //     SizedBox(height: 20),
              //       //     CustomButton(
              //       //       width: MediaQuery.of(context).size.width * 1,
              //       //       padding: EdgeInsets.all(10),
              //       //       color: salary_by_agreement ? kColorPrimary : Colors.grey[200],
              //       //       textColor: salary_by_agreement ? Colors.white : kColorPrimary,
              //       //       onPressed: () {
              //       //         setState(() {
              //       //           salary_by_agreement = !salary_by_agreement;
              //       //         });
              //       //         salary_by_agreement
              //       //             ? _vacancy_salary_controller.text = 'По договоренности'
              //       //             : TextEditingController();
              //       //       },
              //       //       text: 'by_agreement'.tr(),
              //       //     ),
              //       //   ],
              //       // )
              //       //     : Container(),
              //       //
              //       // work == work_mode.isTraining
              //       //     ? Container()
              //       //     : Column(
              //       //   children: <Widget>[
              //       //     SizedBox(height: 20),
              //       //     Align(
              //       //         widthFactor: 10,
              //       //         heightFactor: 1.5,
              //       //         alignment: Alignment.topLeft,
              //       //         child: Text(
              //       //           'vacancy_description'.tr(),
              //       //           style: TextStyle(fontSize: 16, color: Colors.black),
              //       //         )),
              //       //     TextFormField(
              //       //       controller: _vacancy_description_controller,
              //       //       maxLines: 5,
              //       //       focusNode: FocusNode(canRequestFocus: false),
              //       //       decoration: InputDecoration(
              //       //         border: OutlineInputBorder(
              //       //             borderRadius: BorderRadius.circular(10),
              //       //             borderSide: BorderSide.none),
              //       //         floatingLabelBehavior: FloatingLabelBehavior.always,
              //       //         filled: true,
              //       //         fillColor: Colors.grey[200],
              //       //       ),
              //       //       validator: (name) {
              //       //         if (name.isEmpty) {
              //       //           return "please_fill_this_field".tr();
              //       //         }
              //       //         return null;
              //       //       },
              //       //     ),
              //       //   ],
              //       // ),
              //
              //       // /// Область
              //       // work == work_mode.isWork
              //       //     ? Column(
              //       //   children: <Widget>[
              //       //     SizedBox(height: 20),
              //       //     Align(
              //       //       widthFactor: 10,
              //       //       heightFactor: 1.5,
              //       //       alignment: Alignment.topLeft,
              //       //       child: Text(
              //       //         'Область',
              //       //         style: TextStyle(fontSize: 16, color: Colors.black),
              //       //       ),
              //       //     ),
              //       //     DropdownSearch<String>(
              //       //       showSelectedItem: true,
              //       //       items: regions,
              //       //       onChanged: (value) {
              //       //         getDistrictsByRegionName(value);
              //       //         setState(() {
              //       //           selectedRegion = value;
              //       //         });
              //       //       },
              //       //       dropdownSearchDecoration: InputDecoration(
              //       //           border: OutlineInputBorder(
              //       //             borderRadius: BorderRadius.circular(10),
              //       //             borderSide: BorderSide.none,
              //       //           ),
              //       //           filled: true,
              //       //           fillColor: Colors.grey[200],
              //       //           contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
              //       //       selectedItem: selectedRegion,
              //       //     )
              //       //   ],
              //       // )
              //       //     : Container(),
              //       // SizedBox(height: 20),
              //
              //       // /// Район
              //       // work == work_mode.isWork
              //       //     ? Column(
              //       //   children: <Widget>[
              //       //     Align(
              //       //       widthFactor: 10,
              //       //       heightFactor: 1.5,
              //       //       alignment: Alignment.topLeft,
              //       //       child: Text(
              //       //         'Район',
              //       //         style: TextStyle(fontSize: 16, color: Colors.black),
              //       //       ),
              //       //     ),
              //       //     DropdownSearch<String>(
              //       //       showSelectedItem: true,
              //       //       items: districts,
              //       //       onChanged: (value) {
              //       //         setState(() {
              //       //           selectedDistrict = value;
              //       //         });
              //       //       },
              //       //       dropdownSearchDecoration: InputDecoration(
              //       //           border: OutlineInputBorder(
              //       //             borderRadius: BorderRadius.circular(10),
              //       //             borderSide: BorderSide.none,
              //       //           ),
              //       //           filled: true,
              //       //           fillColor: Colors.grey[200],
              //       //           contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
              //       //       selectedItem: selectedDistrict,
              //       //     )
              //       //   ],
              //       // )
              //       //     : Container(),
              //
              //       // /// Сферы деятельности ishtapp
              //       // work == work_mode.isWork
              //       //     ? Column(
              //       //   children: <Widget>[
              //       //     SizedBox(height: 20),
              //       //     DropdownButtonFormField<int>(
              //       //       isExpanded: true,
              //       //       hint: Text("job_types".tr()),
              //       //       value: _job_type_id,
              //       //       onChanged: (int newValue) {
              //       //         setState(() {
              //       //           _job_type_id = newValue;
              //       //         });
              //       //       },
              //       //       focusNode: FocusNode(canRequestFocus: false),
              //       //       validator: (value) =>
              //       //       value == null ? "please_fill_this_field".tr() : null,
              //       //       decoration: InputDecoration(
              //       //         enabledBorder: UnderlineInputBorder(
              //       //           borderSide: BorderSide(color: Colors.grey),
              //       //         ),
              //       //       ),
              //       //       items: jobTypeList.map<DropdownMenuItem<int>>((dynamic value) {
              //       //         var jj = new JobType(id: value['id'], name: value['name']);
              //       //         return DropdownMenuItem<int>(
              //       //           value: jj.id,
              //       //           child: Text(value['name']),
              //       //         );
              //       //       }).toList(),
              //       //     ),
              //       //     SizedBox(height: 20),
              //       //     DropdownButtonFormField<int>(
              //       //       isExpanded: true,
              //       //       hint: Text("vacancy_types".tr()),
              //       //       value: _vacancy_type_id,
              //       //       onChanged: (int newValue) {
              //       //         setState(() {
              //       //           _vacancy_type_id = newValue;
              //       //         });
              //       //       },
              //       //       focusNode: FocusNode(canRequestFocus: false),
              //       //       validator: (value) =>
              //       //       value == null ? "please_fill_this_field".tr() : null,
              //       //       decoration: InputDecoration(
              //       //         enabledBorder: UnderlineInputBorder(
              //       //           borderSide: BorderSide(color: Colors.grey),
              //       //         ),
              //       //       ),
              //       //       items: vacancyTypeList.map<DropdownMenuItem<int>>((dynamic value) {
              //       //         var jj = new JobType(id: value['id'], name: value['name']);
              //       //         return DropdownMenuItem<int>(
              //       //           value: jj.id,
              //       //           child: Text(value['name']),
              //       //         );
              //       //       }).toList(),
              //       //     ),
              //       //     SizedBox(height: 20),
              //       //     DropdownButtonFormField<int>(
              //       //       isExpanded: true,
              //       //       hint: Text("busynesses".tr()),
              //       //       value: _busyness_id,
              //       //       onChanged: (int newValue) {
              //       //         setState(() {
              //       //           _busyness_id = newValue;
              //       //         });
              //       //       },
              //       //       focusNode: FocusNode(canRequestFocus: false),
              //       //       validator: (value) =>
              //       //       value == null ? "please_fill_this_field".tr() : null,
              //       //       decoration: InputDecoration(
              //       //         enabledBorder: UnderlineInputBorder(
              //       //           borderSide: BorderSide(color: Colors.grey),
              //       //         ),
              //       //       ),
              //       //       items: busynessList.map<DropdownMenuItem<int>>((dynamic value) {
              //       //         var jj = new JobType(id: value['id'], name: value['name']);
              //       //         return DropdownMenuItem<int>(
              //       //           value: jj.id,
              //       //           child: Text(value['name']),
              //       //         );
              //       //       }).toList(),
              //       //     ),
              //       //     SizedBox(height: 20),
              //       //     DropdownButtonFormField<int>(
              //       //       isExpanded: true,
              //       //       hint: Text("schedules".tr()),
              //       //       value: _schedule_id,
              //       //       onChanged: (int newValue) {
              //       //         setState(() {
              //       //           _schedule_id = newValue;
              //       //         });
              //       //       },
              //       //       focusNode: FocusNode(canRequestFocus: false),
              //       //       validator: (value) =>
              //       //       value == null ? "please_fill_this_field".tr() : null,
              //       //       decoration: InputDecoration(
              //       //         enabledBorder: UnderlineInputBorder(
              //       //           borderSide: BorderSide(color: Colors.grey),
              //       //         ),
              //       //       ),
              //       //       items: scheduleList.map<DropdownMenuItem<int>>((dynamic value) {
              //       //         var jj = new JobType(id: value['id'], name: value['name']);
              //       //         return DropdownMenuItem<int>(
              //       //           value: jj.id,
              //       //           child: Text(value['name']),
              //       //         );
              //       //       }).toList(),
              //       //     ),
              //       //   ],
              //       // )
              //       //     : Container(),
              //       //
              //       // work == work_mode.isWork ? SizedBox(height: 20) : Container(),
              //       // work == work_mode.isWork
              //       //     ? CheckboxListTile(
              //       //   contentPadding: EdgeInsets.zero,
              //       //   title: Text(
              //       //     'for_disabilities_people'.tr(),
              //       //     style: TextStyle(fontSize: 16, color: Colors.black),
              //       //   ),
              //       //   controlAffinity: ListTileControlAffinity.leading,
              //       //   value: is_disability_person_vacancy,
              //       //   onChanged: (value) {
              //       //     setState(() {
              //       //       is_disability_person_vacancy = value;
              //       //     });
              //       //   },
              //       // )
              //       //     : Container(),
              //       // work == work_mode.isWork ? SizedBox(height: 20) : Container(),
              //       // SizedBox(
              //       //   width: double.maxFinite,
              //       //   child: Row(
              //       //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       //     children: [
              //       //       CustomButton(
              //       //         width: MediaQuery.of(context).size.width * 0.3,
              //       //         padding: EdgeInsets.all(10),
              //       //         color: Colors.grey[200],
              //       //         textColor: kColorPrimary,
              //       //         onPressed: () {
              //       //           setState(() {
              //       //             _schedule_id = null;
              //       //             _busyness_id = null;
              //       //             _job_type_id = null;
              //       //             _vacancy_type_id = null;
              //       //             _region_id = null;
              //       //             _district_id = null;
              //       //           });
              //       //           Navigator.of(context).pop();
              //       //         },
              //       //         text: 'cancel'.tr(),
              //       //       ),
              //       //       CustomButton(
              //       //         width: MediaQuery.of(context).size.width * 0.3,
              //       //         padding: EdgeInsets.all(10),
              //       //         color: kColorPrimary,
              //       //         textColor: Colors.white,
              //       //         onPressed: () {
              //       //           if (_vacancyAddFormKey.currentState.validate()) {
              //       //             setState(() {
              //       //               loading = true;
              //       //             });
              //       //             Vacancy company_vacancy = new Vacancy(
              //       //               name: _vacancy_name_controller.text,
              //       //               salary: _vacancy_salary_controller.text,
              //       //               salary_from: _vacancy_salary_from_controller.text,
              //       //               salary_to: _vacancy_salary_to_controller.text,
              //       //               is_disability_person_vacancy: is_disability_person_vacancy ? 1 : 0,
              //       //               description: _vacancy_description_controller.text,
              //       //               type: _vacancy_type_id != null ? _vacancy_type_id.toString() : null,
              //       //               busyness: _busyness_id != null ? _busyness_id.toString() : null,
              //       //               schedule: _schedule_id != null ? _schedule_id.toString() : null,
              //       //               job_type: _job_type_id != null ? _job_type_id.toString() : null,
              //       //               region: _region_id != null ? _region_id.toString() : null,
              //       //               district: _district_id != null ? _district_id.toString() : null,
              //       //               currency: _currency_id != null ? _currency_id.toString() : null,
              //       //               opportunity: opportunity,
              //       //               opportunityType: opportunityType,
              //       //               opportunityDuration: opportunityDuration,
              //       //               internshipLanguage: selectedInternshipType,
              //       //               typeOfRecommendedLetter: selectedTypeOfRecommendedLetter,
              //       //               ageFrom: _ageFromController.text,
              //       //               ageTo: _ageToController.text,
              //       //               isProductLabVacancy: work_mode.isTraining == work,
              //       //             );
              //       //             SkillCategory skillCategory = new SkillCategory();
              //       //             Vacancy.saveCompanyVacancy(vacancy: company_vacancy).then((value) {
              //       //               skillCategory.saveVacancySkills(tags, selectedCategoryIdFromFirstChip, value, true);
              //       //               skillCategory.saveVacancySkills(tags2, selectedCategoryIdSecondChip, value, false)
              //       //                   .then((value) {
              //       //                 StoreProvider.of<AppState>(context).dispatch(getCompanyVacancies());
              //       //                 Navigator.of(context).pop();
              //       //               });
              //       //               setState(() {
              //       //                 loading = false;
              //       //               });
              //       //             });
              //       //
              //       //             _vacancy_name_controller = TextEditingController();
              //       //             _vacancy_salary_controller = TextEditingController();
              //       //             _vacancy_salary_from_controller = TextEditingController();
              //       //             _vacancy_salary_to_controller = TextEditingController();
              //       //             _vacancy_description_controller = TextEditingController();
              //       //             _ageFromController = TextEditingController();
              //       //             _ageToController = TextEditingController();
              //       //             setState(() {
              //       //               _schedule_id = null;
              //       //               _busyness_id = null;
              //       //               _job_type_id = null;
              //       //               _vacancy_type_id = null;
              //       //               _region_id = null;
              //       //               _district_id = null;
              //       //               _currency_id = null;
              //       //               opportunity = null;
              //       //               opportunityType = null;
              //       //               opportunityDuration = null;
              //       //               selectedInternshipType = null;
              //       //               selectedTypeOfRecommendedLetter = null;
              //       //             });
              //       //           } else {
              //       //             print('invalid');
              //       //           }
              //       //         },
              //       //         text: 'add'.tr(),
              //       //       ),
              //       //     ],
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
