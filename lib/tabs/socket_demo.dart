import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketDemo extends StatefulWidget {
  SocketDemo() : super();

  final String title = "Socket Demo";

  @override
  SocketDemoState createState() => SocketDemoState();
}

class SocketDemoState extends State<SocketDemo> with WidgetsBindingObserver {
  WebSocketChannel channel;

  String _status;
  SocketUtil _socketUtil;

  List<String> _messages;
  TextEditingController _textEditingController;
  int userSelected = 1;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _status = "";
    _messages = List<String>();
    _socketUtil = SocketUtil();
    _socketUtil.initSocket(connectListener, messageListener);
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      /*padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(
                    5.0,
                  ),
                ),
              ),
              filled: true,
              fillColor: Colors.white60,
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Enter message',
            ),
          ),
          OutlineButton(
            child: Text("Send Message"),
            onPressed: () {
              if (_textEditingController.text.isEmpty) {
                return;
              }
              _socketUtil.sendMessage(_textEditingController.text).then(
                    (bool messageSent) {
                  if (messageSent) {
                    _textEditingController.text = "";
                  }
                },
              );
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(_status),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: null == _messages ? 0 : _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  _messages[index],
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                );
              },
            ),
          ),
        ],
      ),*/
    );
  }

  void messageListener(String message) {
    print('Adding message');
    setState(() {
      _messages.add(message);
    });
  }

  void connectListener(bool connected) {
    setState(() {
      _status = "Status: " + (connected ? "Connected" : "Failed to Connect");
    });
  }
}

class SocketUtil {
  Socket _socket;
  bool socketInit = false;
  static const String SERVER_IP = "192.168.0.103";
  static const int SERVER_PORT = 8000;

  Future<bool> sendMessage(String message) async {
    try {
      _socket.add(utf8.encode(message));
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  Future<bool> initSocket(
      Function connectListener, Function messageListener) async {
    try {
      print('Connecting to socket');
      _socket = await Socket.connect(SERVER_IP, SERVER_PORT);
      connectListener(true);
      _socket.listen((List<int> event) {
        messageListener(utf8.decode(event));
      });
      socketInit = true;
    } catch (e) {
      print(e.toString());
      connectListener(false);
      return false;
    }
    return true;
  }

  void closeSocket() {
    _socket.close();
    _socket = null;
  }

  void cleanUp() {
    if (null != _socket) {
      _socket.destroy();
    }
  }
}
