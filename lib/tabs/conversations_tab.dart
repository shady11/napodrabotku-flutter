import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/constants/configs.dart';
import 'package:redux/redux.dart';
import 'package:ishapp/datas/app_state.dart';
import 'package:ishapp/datas/chat.dart';
import 'package:ishapp/datas/RSAA.dart';
import 'package:ishapp/screens/chat_screen.dart';
import 'package:ishapp/tabs/socket_demo.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:ishapp/widgets/badge.dart';
import 'package:ishapp/widgets/svg_icon.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ConversationsTab extends StatefulWidget {
  @override
  _ConversationsTabState createState() => _ConversationsTabState();
}

class _ConversationsTabState extends State<ConversationsTab> {

  void handleInitialBuild(ChatListProps props) {
    props.getChatList();
  }
  // Variables
  final List<bool> _isReadNotifDemo = [false, false, false, true, true, true];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChatListProps>(
      converter: (store) => mapStateToChatProps(store),
      onInitialBuild: (props) => this.handleInitialBuild(props),
      builder: (context, props) {
        List<ChatView> data = props.list.data;
        bool loading = props.list.loading;

        Widget body;
        if (loading) {
          body = Center(
            child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(kColorPrimary),),
          );
        } else {
          body = Column(
      children: [
        SizedBox(height: 20,),
        /// Conversations
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(height: 10),
            itemCount: data.length,
            itemBuilder: ((context, index) {
              /// Get user object
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
//                color: !_isReadNotifDemo[index]
//                    ? kColorPrimary.withAlpha(40)
//                    : null,
                child: ListTile(
                  /*leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        SERVER_IP +
                            *//*data[index].avatar,*//*Prefs.getString(Prefs.PROFILEIMAGE),
                        headers: {
                          "Authorization":
                          Prefs.getString(Prefs.TOKEN)
                        }),
                  ),*/
                  title: Text(data[index].name,
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  subtitle: Text(data[index].last_message),
                  trailing: !_isReadNotifDemo[index] ? Badge(text: data[index].num_of_unreads.toString()) : null,
                  onTap: () {
                    /// Go to chat screen
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(user_id: data[index].user_id, name: data[index].name,)));
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
        }

        return body;
      },
    );
  }
}

class ChatListProps {
  final Function getChatList;
  final ListChatViewState list;

  ChatListProps({
    this.getChatList,
    this.list,
  });
}

ChatListProps mapStateToChatProps(Store<AppState> store) {
  return ChatListProps(
    list: store.state.chat.chat_list,
    getChatList: ()=>store.dispatch(getChatList()),
  );
}
