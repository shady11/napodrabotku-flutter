import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishapp/components/custom_button.dart';
import 'package:ishapp/datas/RSAA.dart';
import 'package:ishapp/datas/app_state.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/datas/vacancy_screen.dart';
import 'package:ishapp/datas/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ishapp/datas/vacancy.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/profile_card.dart';
import 'package:ishapp/widgets/vacancy_view.dart';
import 'package:redux_thunk/redux_thunk.dart';


class DiscoverTab extends StatefulWidget {
  @override
  _DiscoverTabState createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab> {
  void handleInitialBuild(VacanciesScreenProps props) {
    props.getVacancies();
  }
  int button = 0;
  int some_index = 0;
  int offset = 5;

  void removeCards({String type, int vacancy_id, props, context}) {
    Vacancy.saveVacancyUser(vacancy_id: vacancy_id, type: type);
    setState(() {
//      StoreProvider.of<AppState>(context).state.vacancy.liked_list.data.add(new Vacancy());
      props.listResponse.data.removeLast();
    });
    Vacancy.getVacancyByOffset(
        offset: /*offset<0?0:offset*/4,
        job_type_ids: StoreProvider.of<AppState>(context).state.vacancy.job_type_ids,
        region_ids: StoreProvider.of<AppState>(context).state.vacancy.region_ids,
        schedule_ids: StoreProvider.of<AppState>(context).state.vacancy.schedule_ids,
        busyness_ids: StoreProvider.of<AppState>(context).state.vacancy.busyness_ids,
        vacancy_type_ids: StoreProvider.of<AppState>(context).state.vacancy.vacancy_type_ids,
        type: StoreProvider.of<AppState>(context).state.vacancy.type).then((value) {
          if(value != null){
            offset = offset-1;
            print(props.listResponse.data);
            setState(() {
              props.listResponse.data.insert(0, value);
            });
          }
    });

//    StoreProvider.of<AppState>(context).state.vacancy.list.data.last;
//    props.getVacancies();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VacanciesScreenProps>(
      converter: (store) => mapStateToProps(store),
      onInitialBuild: (props) => this.handleInitialBuild(props),
      builder: (context, props) {
        List<Vacancy> data = props.listResponse.data;
        bool loading = props.listResponse.loading;

        Widget body;
        if (loading) {
          body = Center(
            child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
          );
        } else {
          body = Stack(
              alignment: Alignment.topCenter,
              fit: StackFit.expand,
              children: [
                Container(
                  child: Stack(alignment: Alignment.center, children: [
                    for (int x = 0; x < data.length; x++)
                      Positioned(
                        bottom: ((x) * 10.0),
                        child: Draggable(
                            onDragEnd: (drag) {
                              print(
                                  "============================================");
                              print(drag.offset.dy);
                              print(drag.offset.dx);
                              print(
                                  "============================================");
                              if (drag.offset.dx < -200) {
                                removeCards(props: props, type: "DISLIKED", vacancy_id: data[x].id, context: context);
                              }
                              if (drag.offset.dx > 200) {
                                removeCards(props: props, type: "LIKED", vacancy_id: data[x].id, context: context);
                              }
                            },
                            childWhenDragging: Container(),
                            feedback: GestureDetector(
                              onTap: () {
                                print("Hello All");
                              },
                              child: ProfileCard(
                                page: 'discover',
                                vacancy: data[x],
                                index: data.length - x,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return Scaffold(
                                        backgroundColor: kColorPrimary,
                                        appBar: AppBar(
                                          title: Text("vacancy_view".tr()),
                                        ),
                                        body: VacancyView(
                                          page:"view",
                                          vacancy: data[x],
                                        ),
                                      );
                                    }));
                              },
                              child: ProfileCard(
                                page: 'discover',
                                vacancy: data[x],
                                index: data.length - x,
                              ),
                            )),
                      ),
                  ]),
                ),
              ]);
        }

        return Stack(children: [
          body,
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
                      StoreProvider.of<AppState>(context)
                          .dispatch(setTimeFilter(type: StoreProvider.of<AppState>(context).state.vacancy.type=='day' ?'all':'day' ));
                      StoreProvider.of<AppState>(context)
                          .dispatch(getVacancies());
//                      Navigator.of(context).popAndPushNamed(Routes.signup);
//                      setState(() {
//                        button == 1? button =0:button=1;
//                      });
                    },
                    text: StoreProvider.of<AppState>(context).state.vacancy.type=='day' ?'all'.tr():'day'.tr(),
                  ),
                  CustomButton(
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.all(2),
                    color: Colors.white,
                    textColor: kColorPrimary,
                    onPressed: () {
                      StoreProvider.of<AppState>(context)
                          .dispatch(setTimeFilter(type:  StoreProvider.of<AppState>(context).state.vacancy.type=='week' ?'all':'week'));
                      StoreProvider.of<AppState>(context)
                          .dispatch(getVacancies());
//                      Navigator.of(context).popAndPushNamed(Routes.signup);
//                      setState(() {
//                        button == 2? button =0:button=2;
//                      });
                    },
                    text: StoreProvider.of<AppState>(context).state.vacancy.type=='week' ?'all'.tr():'week'.tr(),
                  ),
                  CustomButton(
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.all(2),
                    color: Colors.white,
                    textColor: kColorPrimary,
                    onPressed: () {
                      StoreProvider.of<AppState>(context)
                          .dispatch(setTimeFilter(type: StoreProvider.of<AppState>(context).state.vacancy.type=='month' ?'all':'month'));
                      StoreProvider.of<AppState>(context)
                          .dispatch(getVacancies());
//                      Navigator.of(context).popAndPushNamed(Routes.signup);
                      setState(() {
                        button == 3? button =0:button=3;
                      });
                    },
                    text: StoreProvider.of<AppState>(context).state.vacancy.type=='month' ?'all'.tr():'month'.tr(),
                  ),
                ],
              ),
            ),
          ),
        ]);
      },
    );
  }
}
class VacanciesScreenProps {
  final Function getVacancies;
  final Function deleteItem;
  final ListVacancysState listResponse;

  VacanciesScreenProps({
    this.getVacancies,
    this.listResponse,
    this.deleteItem
  });
}

VacanciesScreenProps mapStateToProps(Store<AppState> store) {
  return VacanciesScreenProps(
    listResponse: store.state.vacancy.list,
    getVacancies: () => store.dispatch(getVacancies()),
    deleteItem: () => store.dispatch(deleteItem1()),
  );
}
