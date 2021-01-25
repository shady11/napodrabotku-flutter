import 'package:flutter/material.dart';
import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/cicle_button.dart';
import 'package:ishapp/widgets/profile_card.dart';
import 'package:ishapp/widgets/swipe_buttons.dart';
import 'package:swipe_stack/swipe_stack.dart';

class DiscoverTab extends StatefulWidget {
  @override
  _DiscoverTabState createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab> {
  // Variables
  final _swipeKey = GlobalKey<SwipeStackState>();


  openFilterDialog(context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(20.0)),
            child: Container(
              constraints: BoxConstraints(maxHeight: 350),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text:"sdfsdf",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black,
                              wordSpacing: 1
                          )
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
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height*0.6,
            child: SwipeStack(
              key: _swipeKey,
              children: getDemoVacancies().map((vacancy) {
                return SwiperItem(
                    builder: (SwiperPosition position, double progress) {
                  /// Return User Card
                  return ProfileCard(
                      page: 'discover',
                      position: position,
                      vacancy: vacancy
                  );
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
                  icon: Icon(Icons.filter_list, size: 22, color: Colors.grey)
                ),
                onTap: (){
                  openFilterDialog(context);
                },
              ),
          )
          ),

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
