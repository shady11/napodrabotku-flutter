
import 'package:flutter/material.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/screens/profile_screen.dart';
import 'package:ishapp/widgets/chat_message.dart';
import 'package:ishapp/widgets/svg_icon.dart';

class ChatScreen extends StatefulWidget {
  /// Get user object
  final User user;

  ChatScreen({@required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Variables
  final _textController = TextEditingController();
  bool _isComposing = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 0),
            leading: CircleAvatar(
              backgroundImage: AssetImage(widget.user.userPhotoLink),
            ),
            title: Text(widget.user.userFullname,
                style: TextStyle(fontSize: 18)),
          ),
          onTap: () {
              /// Go to profile screen
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfileScreen(
                    user: widget.user,
              )));
          },
        ),
        actions: <Widget>[
          /// Actions list
          PopupMenuButton<String>(
            initialValue: "",
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              /// Delete Chat
              PopupMenuItem(
                  value: "delete_chat",
                  child: Row(
                    children: <Widget>[
                      SvgIcon("assets/icons/trash_icon.svg", 
                      width: 20, height: 20, 
                      color: Theme.of(context).primaryColor),
                      SizedBox(width: 5),
                      Text("Delete conversation"),
                    ],
              )),

              /// Undo Match
              PopupMenuItem(
                  value: "undo_match",
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.highlight_off,
                          color: Theme.of(context).primaryColor),
                      SizedBox(width: 5),
                      Text("Undo Match")
                    ],
                  )),
            ],
            onSelected: (val) {
              /// Control selected value
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                /// Chat list
                
                /// Current user
                ChatMessage(
                  isUserSender: true,
                  userPhotoLink: "assets/images/man.jpg",
                  textMessage: "Hi, how are you?",
                  timeAgo: "0 min ago",
                ),

                ChatMessage(
                  isUserSender: false,
                  userPhotoLink: widget.user.userPhotoLink,
                  textMessage: "Fine, thanks. You?",
                  timeAgo: "1 min ago",
                ),

                /// Current user
                ChatMessage(
                  isUserSender: true,
                  userPhotoLink: "assets/images/man.jpg",
                  textMessage: "Great. Can you send me your picture now?",
                  timeAgo: "0 min ago",
                ),

                ChatMessage(
                  isUserSender: false,
                  isImage: true,
                  userPhotoLink: widget.user.userPhotoLink,
                  imageLink: widget.user.userPhotoLink,
                  timeAgo: "1 min ago",
                ),
              ],
            ),
          ),

          /// Text Composer
          Container(
            color: Colors.grey.withAlpha(50),
            child: ListTile(
                leading: IconButton(
                    icon: SvgIcon("assets/icons/camera_icon.svg", 
                    width: 20, height: 20),
                    onPressed: () async {
                      /// Send image file
                    }),
                title: TextField(
                  controller: _textController,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: "Type a message", border: InputBorder.none),

                  onChanged: (text) {
                    setState(() {
                      _isComposing = text.isNotEmpty;
                    });
                  },
                ),
                trailing: IconButton(
                  icon: Icon(Icons.send,
                  color: _isComposing ? Theme.of(context).primaryColor
                          : Colors.grey),
                  onPressed: _isComposing ? () async { 
                    /// Send text message
                    
                    // clear input text
                    _textController.clear();

                    // Change state
                    setState(() => _isComposing = false);

                }: null)),
          ),
        ],
      ),
    );
  }
}
