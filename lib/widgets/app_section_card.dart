import 'package:flutter/material.dart';
import 'package:ishapp/widgets/svg_icon.dart';

import 'default_card_border.dart';

class AppSectionCard extends StatelessWidget {
  // Variables
    final _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: defaultCardBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Aplication",
                style: TextStyle(fontSize: 20, color: Colors.grey),
                textAlign: TextAlign.left),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("About us", style: _textStyle),
            onTap: () {
              /// Go to About us

            },
          ),
          Divider(height: 0),
          ListTile(
            leading: SvgIcon("assets/icons/facebook_icon.svg",
                width: 22, height: 22),
            title: Text("Like our facebook page", style: _textStyle),
            onTap: () {
              /// Open facebook page
            },
          ),
          Divider(height: 0),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share with friends", style: _textStyle),
            onTap: () {
              /// Share app
            },
          ),
          Divider(height: 0),
          ListTile(
            leading:
                SvgIcon("assets/icons/star_icon.svg", width: 22, height: 22),
            title: Text("Rate on Play Store", style: _textStyle),
            onTap: () async {
              /// Go to play store
            },
          ),
          Divider(height: 0),
          ListTile(
            leading:
                SvgIcon("assets/icons/lock_icon.svg", width: 22, height: 22),
            title: Text("Privacy Policy", style: _textStyle),
            onTap: () async {
              /// Go to privacy policy
            },
          ),
        ],
      ),
    );
  }
}
