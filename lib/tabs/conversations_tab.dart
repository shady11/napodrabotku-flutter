import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/screens/chat_screen.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/badge.dart';
import 'package:ishapp/widgets/svg_icon.dart';

class ConversationsTab extends StatefulWidget {
  @override
  _ConversationsTabState createState() => _ConversationsTabState();
}

class _ConversationsTabState extends State<ConversationsTab> {
  // Variables
  final List<bool> _isReadNotifDemo = [false, false, false, true, true, true];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Title
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("sms".tr(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ),

        /// Conversations
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(height: 10),
            itemCount: getDemoUsers().length,
            itemBuilder: ((context, index) {
              /// Get user object
              final User user = getDemoUsers()[index];

              return Container(
                color: !_isReadNotifDemo[index]
                    ? kColorPrimary.withAlpha(40)
                    : null,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(user.userPhotoLink),
                  ),
                  title: Text(user.userFullname.split(",")[0],
                      style: TextStyle(fontSize: 18)),
                  subtitle: Text("Hi, how are you?\n$index min ago"),
                  trailing: !_isReadNotifDemo[index] ? Badge(text: "2") : null,
                  onTap: () {
                    /// Go to chat screen
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(user: user)));
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
