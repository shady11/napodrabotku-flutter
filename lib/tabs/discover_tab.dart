import 'package:flutter/material.dart';
import 'package:ishapp/datas/demo_users.dart';
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        /// User card list
        SwipeStack(
          key: _swipeKey,
          children: getDemoUsers().map((user) {
            return SwiperItem(
                builder: (SwiperPosition position, double progress) {
              /// Return User Card
              return ProfileCard(
                  page: 'discover', 
                  position: position,
                  user: user
              );
            });
          }).toList(),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          historyCount: getDemoUsers().length,
          translationInterval: 6,
          scaleInterval: 0.03,
          stackFrom: StackFrom.None,
          onEnd: () => debugPrint("onEnd"),
          onSwipe: (int index, SwiperPosition position) =>
              debugPrint("onSwipe $index $position"),
          onRewind: (int index, SwiperPosition position) =>
              debugPrint("onRewind $index $position"),
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
