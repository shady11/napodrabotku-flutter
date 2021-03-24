import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ishapp/datas/app_state.dart';
import 'package:ishapp/datas/chat.dart';
import 'package:ishapp/datas/RSAA.dart';
import 'package:ishapp/screens/profile_screen.dart';
import 'package:ishapp/widgets/chat_message.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/constants/configs.dart';

class ChatScreen extends StatefulWidget {
  /// Get user object
  final int user_id;
  String name;

  ChatScreen({@required this.user_id, this.name});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void handleInitialBuild(MessageListProps props) {
    props.getMessageList(widget.user_id);
  }
  // Variables
  final _textController = TextEditingController();
  bool _isComposing = false;


  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MessageListProps>(
      converter: (store) => mapStateToMessageProps(store, widget.user_id),
      onInitialBuild: (props) => this.handleInitialBuild(props),
      builder: (context, props) {
        List<Message> data = props.list.data;
        bool loading = props.list.loading;

        Widget body;
        if (loading) {
          body = Center(
            child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
          );
        } else {
          body = Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      return ChatMessage(
                        isUserSender: data[index].type,
                        body: data[index].body,
                        date_time: data[index].date_time,
                        read: data[index].read,
                      );
                    }),
              ),
              Container(
                color: Colors.grey.withAlpha(50),
                child: ListTile(
                    title: TextField(
                      controller: _textController,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                          hintText: "write".tr(), border: InputBorder.none),
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
                          ///

                          Message.sendMessage(_textController.text, widget.user_id);
                          // clear input text
                          _textController.clear();

                          // Change state
                          setState(() => _isComposing = false);

                        }: null)),
              ),
            ],
          );
        }


        return Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 0),
                  /*leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        SERVER_IP +
                            Prefs.getString(Prefs.PROFILEIMAGE),
                        headers: {
                          "Authorization":
                          Prefs.getString(Prefs.TOKEN)
                        }),
                  ),*/
                  title: Text(widget.name,
                      style: TextStyle(fontSize: 18)),
                ),
                onTap: () {
                  /// Go to profile screen
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen(
//                    user: widget.user,
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
                            Text("delete_conversation".tr()),
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
            body: body
        );
      },
    );
  }
}



class MessageListProps {
  final Function getMessageList;
  final ListMessageViewState list;

  MessageListProps({
    this.getMessageList,
    this.list,
  });
}

MessageListProps mapStateToMessageProps(Store<AppState> store, int receiver_id) {
  return MessageListProps(
    list: store.state.chat.message_list,
    getMessageList: (int receiver_id)=>store.dispatch(getMessageList(receiver_id)),
  );
}
