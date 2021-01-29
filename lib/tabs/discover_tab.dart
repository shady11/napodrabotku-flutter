import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/datas/demo_users.dart';
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

class _DiscoverTabState extends State<DiscoverTab> {
  // Variables
  final _swipeKey = GlobalKey<SwipeStackState>();
  final _formKey = GlobalKey<FormState>();
  List<String> selectedJobTypeChoices = List();
  List<String> selectedVacancyTypeChoices = List();
  List<String> selectedBusynessChoices = List();
  List<String> selectedScheduleChoices = List();

  List<String> jobTypeList = ['Удаленно', 'В офис'];
  List<String> vacancyTypeList = ['Программист', 'Ментор', 'Водитель'];
  List<String> busynessList = ['Полный рабочий день', 'На пол ставку'];
  List<String> scheduleList = ['Будни', 'Гибкий'];

  _showJobTypeDialog() {
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
  }
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

  openFilterDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: BoxConstraints(maxHeight: 350),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'job_type'.tr(),
                                style: TextStyle(fontSize: 22),
                              ),
                              DefaultButton(
                                child: Text("select_job_type".tr(),
                                    style: TextStyle(fontSize: 13)),
                                onPressed: () => _showJobTypeDialog(),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'vacancy_type'.tr(),
                                style: TextStyle(fontSize: 22),
                              ),
                              DefaultButton(
                                child: Text("select_vacancy_type".tr(),
                                    style: TextStyle(fontSize: 13)),
                                onPressed: () => _showVacancyTypeDialog(),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'busyness'.tr(),
                                style: TextStyle(fontSize: 22),
                              ),
                              DefaultButton(
                                child: Text("select_busyness".tr(),
                                    style: TextStyle(fontSize: 13)),
                                onPressed: () => _showBusynessDialog(),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'schedule'.tr(),
                                style: TextStyle(fontSize: 22),
                              ),
                              DefaultButton(
                                child: Text("select_schedule".tr(),
                                    style: TextStyle(fontSize: 13)),
                                onPressed: () => _showScheduleDialog(),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),

                          /// Sign In button
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DefaultButton(
                                  child: Text("cancel".tr(),
                                      style: TextStyle(fontSize: 13)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                DefaultButton(
                                  child: Text("search".tr(),
                                      style: TextStyle(fontSize: 13)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        /// User card list
        Align(
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
        ),

        /// Filter button
        Container(
            margin: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                child: CircleButton(
                    bgColor: kColorPrimary,
                    padding: 12,
                    icon:
                        Icon(Icons.filter_list, size: 22, color: Colors.grey)),
                onTap: () {
                  openFilterDialog(context);
                },
              ),
            )),

        /// Swipe buttons
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: SwipeButtons(swipeKey: _swipeKey)),
        ),
      ],
    );
  }
}
