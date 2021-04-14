//import 'package:flutter/material.dart';
//import 'package:ishtapp/datas/demo_users.dart';
//import 'package:ishtapp/datas/user.dart';
//import 'package:ishtapp/widgets/badge.dart';
//import 'package:ishtapp/widgets/svg_icon.dart';
//
//
//class NotificationsScreen extends StatefulWidget {
//  @override
//  _NotificationsScreenState createState() => _NotificationsScreenState();
//}
//
//class _NotificationsScreenState extends State<NotificationsScreen> {
//  // Variables
//  final List<bool> _isReadNotifDemo = [true, true, false, true, true, true];
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Notifications (5)"),
//        actions: [
//          IconButton(
//              icon: SvgIcon("assets/icons/trash_icon.svg"),
//              onPressed: () {
//                /// Delete all Notifications
//              })
//        ],
//      ),
//      body: ListView.separated(
//          shrinkWrap: true,
//          separatorBuilder: (context, index) => Divider(height: 10),
//          itemCount: getDemoUsers().length,
//          itemBuilder: ((context, index) {
//            /// Get user object
//            final User user = getDemoUsers()[index];
//
//            return Container(
//              color: !_isReadNotifDemo[index]
//                  ? Theme.of(context).primaryColor.withAlpha(40)
//                  : null,
//              child: ListTile(
//                leading: CircleAvatar(
//                  backgroundColor: Theme.of(context).primaryColor,
//                  backgroundImage: AssetImage(user.userPhotoLink),
//                ),
//                title: Text(user.userFullname.split(",")[0],
//                    style: TextStyle(fontSize: 18)),
//                subtitle: Text("Visited your profile\n$index min ago"),
//                trailing: !_isReadNotifDemo[index] ? Badge(text: "New") : null,
//                onTap: () {
//                  /// Go to page
//                },
//              ),
//            );
//          }),
//        ),
//    );
//  }
//}
