import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishtapp/components/custom_button.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/routes/routes.dart';

class SchoolTab extends StatefulWidget {
  @override
  _SchoolTabState createState() => _SchoolTabState();
}

class _SchoolTabState extends State<SchoolTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            child: Text(
              "soon".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(color: kColorPrimary, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
