import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/datas/vacancy.dart';
import 'package:ishapp/screens/profile_screen.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/profile_card.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/widgets/users_grid.dart';
import 'staggered_trekking.dart';

class ProfileLikesScreen extends StatefulWidget {
  @override
  _ProfileLikesScreenState createState() => _ProfileLikesScreenState();
}

class _ProfileLikesScreenState extends State<ProfileLikesScreen> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  List<Vacancy> vacancyList = new List<Vacancy>();

  getget(){
    Vacancy.getVacancyListByType(10, 0, 'LIKED').then((value) {
      setState(() {
        vacancyList = value;
      });
    });
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    getget();
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      backgroundColor: kColorPrimary,
      appBar: AppBar(
        title: Text("likeds".tr()),
      ),
      body: Column(
      children: [
        /// Title

        SizedBox(height: 20),
        /// Matches
        Expanded(
          child: vacancyList.length !=0 ? UsersGrid(children: vacancyList.map((vacancy) {
              /// Return User Card
              return GestureDetector(
                child: ProfileCard(vacancy: vacancy),
                onTap: () {
                  /// Go to profile screen
//                  Navigator.of(context).push(MaterialPageRoute(
//                    builder: (context) => ProfileScreen(user: user)));
                },
              );
          }).toList()) :  Center(
          heightFactor: 20,
          widthFactor: 20,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 10,
          ),
        ),
        )
      ],
     )
    );*/
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _playAnimation();
      },
      child: StaggeredTrekking(
        controller: _controller,
      ),
    );
  }
}


class StaggeredTrekkingEnterAnimation {
  StaggeredTrekkingEnterAnimation(this.controller)
      : barHeight = Tween<double>(begin: 0, end: 150).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(0, 0.3, curve: Curves.easeIn),
    ),
  ),
        avatarSize = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.3, 0.6, curve: Curves.elasticOut),
          ),
        ),
        titleOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.6, 0.65, curve: Curves.easeIn),
          ),
        ),
        textOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.65, 0.8, curve: Curves.easeIn),
          ),
        ),
        imageOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.8, 0.99, curve: Curves.easeIn),
          ),
        );

  final AnimationController controller;
  final Animation<double> barHeight;
  final Animation<double> avatarSize;
  final Animation<double> titleOpacity;
  final Animation<double> textOpacity;
  final Animation<double> imageOpacity;
//final Animation<double> contactOpacity;
}
