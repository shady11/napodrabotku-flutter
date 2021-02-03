import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:ishapp/components/custom_button.dart';
import 'package:ishapp/routes/routes.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/datas/vacancy.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/cicle_button.dart';
import 'package:ishapp/widgets/profile_card.dart';
import 'package:ishapp/widgets/swipe_buttons.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:ishapp/widgets/default_button.dart';
import 'package:ishapp/widgets/multi_select_chip.dart';

class DiscoverTab extends StatefulWidget {
  @override
  _DiscoverTabState createState() => _DiscoverTabState();
}

class JobType {
  int id;
  String name;

  JobType({this.id, this.name});


}
class _DiscoverTabState extends State<DiscoverTab> {
  // Variables
  final _swipeKey = GlobalKey<SwipeStackState>();
  final _formKey = GlobalKey<FormState>();
  List<String> selectedJobTypeChoices = List();
  List<String> selectedVacancyTypeChoices = List();
  List<String> selectedBusynessChoices = List();
  List<String> selectedScheduleChoices = List();

  final jobTypeList = [JobType(id: 1, name: 'Удаленно'), JobType(id: 2, name: 'В офис'), ];
  List<JobType> _selectedJobTypes = [];
  List<String> vacancyTypeList = ['Программист', 'Ментор', 'Водитель'];
  List<String> busynessList = ['Полный рабочий день', 'На пол ставку'];
  List<String> scheduleList = ['Будни', 'Гибкий'];

  List<Widget> cardList = new List();

  /*_showJobTypeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("job_types".tr()),
            content: MultiSelectChip(
              jobTypeList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedJobTypeChoices = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("ok".tr()),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }*/
  _showVacancyTypeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("vacancy_types".tr()),
            content: MultiSelectChip(
              vacancyTypeList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedVacancyTypeChoices = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("ok".tr()),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }
  _showBusynessDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("busynesses".tr()),
            content: MultiSelectChip(
              busynessList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedBusynessChoices = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("ok".tr()),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }
  _showScheduleDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("schedules".tr()),
            content: MultiSelectChip(
              scheduleList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedScheduleChoices = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("ok".tr()),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }
  List _job_types;
  List _vacancy_types;
  List _busynesses;
  List _schedules;


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
                            dataSource: [
                              {
                                "display": "Удаленно",
                                "value": "1",
                              },
                              {
                                "display": "В офис",
                                "value": "2",
                              },
                            ],
                            textField: 'display',
                            valueField: 'value',
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
                            dataSource: [
                              {
                                "display": "Программист",
                                "value": "1",
                              },
                              {
                                "display": "Водитель",
                                "value": "2",
                              },
                              {
                                "display": "Учитель",
                                "value": "3",
                              },
                              {
                                "display": "Доктор",
                                "value": "4",
                              },
                            ],
                            textField: 'display',
                            valueField: 'value',
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
                            dataSource: [
                              {
                                "display": "На пол ставку",
                                "value": "1",
                              },
                              {
                                "display": "Полный день",
                                "value": "2",
                              },
                            ],
                            textField: 'display',
                            valueField: 'value',
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
                            dataSource: [
                              {
                                "display": "Гибкий",
                                "value": "1",
                              },
                              {
                                "display": "По будням",
                                "value": "2",
                              },
                            ],
                            textField: 'display',
                            valueField: 'value',
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
                                  padding: EdgeInsets.all(15),
                                  color: Colors.grey[200],
                                  textColor: kColorPrimary,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  text: 'cancel'.tr(),
                                ),
                                CustomButton(
                                  padding: EdgeInsets.all(15),
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
  void removeCards(index) {
    setState(() {
      cardList.removeAt(index);
    });
  }

  @override
  initState(){
    cardList = _generateCards();
    _job_types = [];
    _busynesses = [];
    _schedules = [];
    _vacancy_types = [];
  }

  List<Widget> _generateCards() {
    List<Vacancy> vacancies = getDemoVacancies();
    List<Widget> cardList = new List();

    for (int x = 0; x < vacancies.length; x++) {
      cardList.add(
        Positioned(
          bottom: 40+(x*15.0),
          child: Draggable(
              onDragEnd: (drag) {
                print("============================================");
                print(drag.offset.dy);
                print(drag.offset.dx);
                print("============================================");

                if(drag.offset.dx < -150){
                  removeCards(x);
                }

                if(drag.offset.dx > 150){
                  removeCards(x);
                }
              },
              childWhenDragging: Container(),
              feedback: GestureDetector(
                onTap: () {
                  print("Hello All");
                },
                child: ProfileCard(
                    page: 'discover',  vacancy: vacancies[x]),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return ProfileCard(vacancy: vacancies[x],);
                  }));
                },
                child: ProfileCard(
                    page: 'discover',  vacancy: vacancies[x]),
              )),
        ),
      );
    }
    return cardList;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        /// User card list

        /*Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            child: SwipeStack(
              key: _swipeKey,
              children: getDemoVacancies().map((vacancy) {
                return SwiperItem(
                    builder: (SwiperPosition position, double progress) {
                  /// Return User Card
                  return ProfileCard(
                      page: 'discover', position: position, vacancy: vacancy);
                });
              }).toList(),
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              historyCount: getDemoUsers().length,
              translationInterval: 6,
              scaleInterval: 0.5,
              stackFrom: StackFrom.None,
              onEnd: () => debugPrint("onEnd"),
              onSwipe: (int index, SwiperPosition position) =>
                  debugPrint("onSwipe $index $position"),
              onRewind: (int index, SwiperPosition position) =>
                  debugPrint("onRewind $index $position"),
            ),
          ),
        ),*/
        Container(
          child: Stack(alignment: Alignment.center, children: cardList),
        ),

        /// Filter button
        Container(
            margin: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text(
                      'ishtapp',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                  ),
                  SizedBox(width: 18,),
                  GestureDetector(
                    child: CircleButton(
//                        bgColor: Colors.white,
                        padding: 12,
                        icon: Icon(Boxicons.bx_filter, color: Colors.white, size: 35,)
                    ),
                    onTap: () {
                      openFilterDialog(context);
                    },
                  ),
                ],
              ),
            )),

        /// Swipe buttons
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Align(
              alignment: Alignment.lerp(new Alignment(-1.0, -0.80), new Alignment(1, -0.80), 20),
              widthFactor: MediaQuery.of(context).size.width * 1,
              heightFactor: MediaQuery.of(context).size.height * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    padding: EdgeInsets.all(2),
                    color: Colors.white,
                    textColor: kColorPrimary,
                    onPressed: () {
//                      Navigator.of(context).popAndPushNamed(Routes.signup);
                    },
                    text: 'day'.tr(),
                  ),
                  CustomButton(
                    padding: EdgeInsets.all(2),
                    color: Colors.white,
                    textColor: kColorPrimary,
                    onPressed: () {
//                      Navigator.of(context).popAndPushNamed(Routes.signup);
                    },
                    text: 'week'.tr(),
                  ),
                  CustomButton(
                    padding: EdgeInsets.all(2),
                    color: Colors.white,
                    textColor: kColorPrimary,
                    onPressed: () {
//                      Navigator.of(context).popAndPushNamed(Routes.signup);
                    },
                    text: 'month'.tr(),
                  ),
                ],
              ),
          ),
        ),
      ],
    );
  }
}