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
  int limit;
  int offset;
  List job_type_ids;
  List schedule_ids;
  List busyness_ids;
  List vacancy_type_ids;

  DiscoverTab(
      {this.limit,
      this.offset,
      this.job_type_ids,
      this.schedule_ids,
      this.busyness_ids,
      this.vacancy_type_ids});

  @override
  _DiscoverTabState createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab> {
  List<String> selectedJobTypeChoices = List();
  List<String> selectedVacancyTypeChoices = List();
  List<String> selectedBusynessChoices = List();
  List<String> selectedScheduleChoices = List();
  List<Vacancy> vacancies = new List();

  List<Widget> cardList = new List();

  void removeCards(index, String type) {
    if(type == 'left'){

    }
    else{

    }
    setState(() {
      var some = vacancies.last;
      vacancies.removeAt(index);
      vacancies.insert(0, some);
    });
  }

  @override
  initState() {
    super.initState();
    Vacancy.getVacancyList(widget.limit, widget.offset, widget.job_type_ids, widget.schedule_ids, widget.busyness_ids, widget.vacancy_type_ids).then((value) {
      setState(() {
        vacancies = value;
      });
    });
  }

  getget(){
    setState(() {
      Vacancy.getVacancyList(widget.limit, widget.offset, widget.job_type_ids, widget.schedule_ids, widget.busyness_ids, widget.vacancy_type_ids).then((value) {
        vacancies = value;
      });
    });
  }

  Future<List<Widget>> _generateCards() async{
    List<Vacancy> vacancies = await Vacancy.getVacancyList(widget.limit, widget.offset, widget.job_type_ids, widget.schedule_ids, widget.busyness_ids, widget.vacancy_type_ids);
    List<Widget> cardList1 = new List();

    for (int x = 0; x < vacancies.length; x++) {
      cardList1.add(
        Positioned(
          width: MediaQuery.of(context).size.width * 1,
          bottom: 5+(x * 15.0),
          child: Draggable(
              onDragEnd: (drag) {
                print("============================================");
                print(drag.offset.dy);
                print(drag.offset.dx);
                print("============================================");

                if(drag.offset.dx < -200){
                  removeCards(x, 'left');
                }

                if(drag.offset.dx > 200){
                  removeCards(x, 'right');
                }
              },
              childWhenDragging: Container(),
              feedback: GestureDetector(
                onTap: () {
                  print("Hello All");
                },
                child: ProfileCard(
                  page: 'discover',
                  vacancy: vacancies[x],
                  index: vacancies.length - x,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return ProfileCard(
                      vacancy: vacancies[x],
                    );
                  }));
                },
                child: ProfileCard(
                  page: 'discover',
                  vacancy: vacancies[x],
                  index: vacancies.length - x,
                ),
              )
          ),
        ),
      );
    }
    setState(() {
      cardList =cardList1;
    });
    return cardList1;
  }

  @override
  Widget build(BuildContext context) {
//    if(vacancies.length==0){
//      getget();
//    }
    return Stack(
      alignment: Alignment.topCenter,
      fit: StackFit.expand,
      children: [
        /// User card list
        /*Container(
            margin: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.lerp(new Alignment(-1.0, -1), new Alignment(1, -1), 20),
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
                        bgColor: Colors.transparent,
                        padding: 12,
                        icon: Icon(Boxicons.bx_filter, color: Colors.white, size: 35,)
                    ),
                    onTap: () {
                      openFilterDialog(context);
                    },
                  ),
                ],
              ),
            )),*/
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
        vacancies.length !=0?
        Container(
          child: Stack(alignment: Alignment.center, children: [
            for (int x = 0; x < vacancies.length; x++)
              Positioned(
                bottom: 5+(x * 15.0),
                child: Draggable(
                    onDragEnd: (drag) {
                      print("============================================");
                      print(drag.offset.dy);
                      print(drag.offset.dx);
                      print("============================================");

                      if(drag.offset.dx < -200){
                        removeCards(x, 'left');
                      }

                      if(drag.offset.dx > 200){
                        removeCards(x, 'right');
                      }
                    },
                    childWhenDragging: Container(),
                    feedback: GestureDetector(
                      onTap: () {
                        print("Hello All");
                      },
                      child: ProfileCard(
                        page: 'discover',
                        vacancy: vacancies[x],
                        index: vacancies.length - x,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                          return ProfileCard(
                            vacancy: vacancies[x],
                          );
                        }));
                      },
                      child: ProfileCard(
                        page: 'discover',
                        vacancy: vacancies[x],
                        index: vacancies.length - x,
                      ),
                    )
                ),
              ),

          ]),
        ): Center(
          heightFactor: 20,
          widthFactor: 20,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 10,
          ),
        ),

        /// Filter button

        /// Swipe buttons
        Container(
//          margin: const EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.lerp(
                new Alignment(-1.0, -1.0), new Alignment(1, -1.0), 10),
            widthFactor: MediaQuery.of(context).size.width * 1,
            heightFactor: MediaQuery.of(context).size.height * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  width: MediaQuery.of(context).size.width * 0.25,
                  padding: EdgeInsets.all(2),
                  color: Colors.white,
                  textColor: kColorPrimary,
                  onPressed: () {
//                      Navigator.of(context).popAndPushNamed(Routes.signup);
                  },
                  text: 'day'.tr(),
                ),
                CustomButton(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.all(2),
                  color: Colors.white,
                  textColor: kColorPrimary,
                  onPressed: () {
//                      Navigator.of(context).popAndPushNamed(Routes.signup);
                  },
                  text: 'week'.tr(),
                ),
                CustomButton(
                  width: MediaQuery.of(context).size.width * 0.3,
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
