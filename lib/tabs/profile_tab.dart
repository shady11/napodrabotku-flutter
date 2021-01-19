import 'package:flutter/material.dart';
import 'package:ishapp/widgets/app_section_card.dart';
import 'package:ishapp/widgets/profile_basic_info_card.dart';
import 'package:ishapp/widgets/profile_statistics_card.dart';

class ProfileTab extends StatelessWidget {
 
  // Variables

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Basic profile info 
          ProfileBasicInfoCard(),

          SizedBox(height: 10),

          /// Profile Statistics Card
          ProfileStatisticsCard(),

          SizedBox(height: 10),

          /// App Section Card
          AppSectionCard()

        ],
      ),
    );
  }
}
