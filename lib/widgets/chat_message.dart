import 'package:flutter/material.dart';
import 'package:ishapp/utils/constants.dart';

class ChatMessage extends StatelessWidget {
  // Variables
  final bool isUserSender;
  final String userPhotoLink;
  final bool isImage;
  final String imageLink;
  final String textMessage;
  final String timeAgo;

  ChatMessage(
      {@required this.isUserSender,
      @required this.userPhotoLink,
      @required this.timeAgo,
      this.isImage = false,
      this.imageLink,
      this.textMessage});

  @override
  Widget build(BuildContext context) {
    /// User profile photo
//    final _userProfilePhoto = CircleAvatar(
//      backgroundColor: Theme.of(context).primaryColor,
//      backgroundImage: AssetImage(userPhotoLink),
//    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          /// User receiver photo Left
//          !isUserSender ? _userProfilePhoto : Container(width: 0, height: 0),

          SizedBox(width: 10),

          /// User message
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isUserSender
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: <Widget>[
                /// Message container
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: !isUserSender
                        /// Color for receiver
                        ? Colors.grey.withAlpha(70)
                        /// Color for sender
                        : kColorPrimary,
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(textMessage ?? "",
                      style: TextStyle(
                        fontSize: 18,
                        color: isUserSender ? Colors.white : Colors.black),
//                        textAlign: TextAlign.center,
                    ),
                ),

                SizedBox(height: 5),

                /// Message time ago
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(timeAgo, style: TextStyle(color: Colors.grey),)),
              ],
            ),
          ),
          SizedBox(width: 10),

          /// Current User photo right
//          isUserSender ? _userProfilePhoto : Container(width: 0, height: 0),
        ],
      ),
    );
  }
}
