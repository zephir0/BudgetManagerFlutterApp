// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:budget_manager_flutter/api/budget_json_service.dart';
import 'package:budget_manager_flutter/auth/user_session.dart';
import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:flutter/material.dart';

import 'package:budget_manager_flutter/model/chat_message.dart';
import 'package:http/http.dart' as http;

import '../../api/api_service.dart';
import '../../model/ticket.dart';

class ChatScreen extends StatefulWidget {
  final Ticket ticket;

  ChatScreen({Key? key, required this.ticket}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var formKey = GlobalKey<FormState>();
  UserSession session = UserSession();
  final TextEditingController _textController = TextEditingController();
  List<ChatMessage> _messages = [];
  late bool isAdmin;

  @override
  void initState() {
    super.initState();
    getMessages(widget.ticket.id);
    checkIfUserIsAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: GlobalVariables().backgroundGradient),
      child: Column(
        children: [ChatMessageDisplayer(), createMessage(_textController)],
      ),
    ));
  }

  Container ChatMessageDisplayer() {
    return Container(
      child: Expanded(
        child: ListView.builder(
          itemCount: _messages.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: _messages[index].admin
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: chatMessage(),
            );
          },
        ),
      ),
    );
  }

  List<Widget> chatMessage() {
    return _messages
        .map((message) => Row(
              mainAxisAlignment: message.admin
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                message.admin
                    ? avatarAndUserName(message)
                    : showMessage(message),
                message.admin
                    ? showMessage(message)
                    : avatarAndUserName(message)
              ],
            ))
        .toList();
  }

  Padding showMessage(ChatMessage message) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: message.admin
                    ? Color.fromARGB(255, 165, 179, 243)
                    : Color.fromARGB(255, 242, 244, 245),
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              "${message.message}",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ));
  }

  Padding avatarAndUserName(ChatMessage message) => Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_rounded, size: 30),
            Text(
              message.admin ? "Admin" : "Uzytkownik",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  Future<List<ChatMessage>> getMessages(int ticketId) async {
    var url =
        Uri.parse(ApiService().backEndServerUrl + "/api/chat/${ticketId}");
    var response = await http.get(
      url,
      headers: {'Cookie': 'JSESSIONID=${session.cookies}'},
    );

    if (response.statusCode == 200) {
      List<ChatMessage> chatMessages = (json.decode(response.body) as List)
          .map((data) => ChatMessage.fromJson(data))
          .toList();

      setState(() {
        this._messages = chatMessages;
      });
      return chatMessages;
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<void> sendMessage(String message) async {
    try {
      final response = await http.post(
          Uri.parse(
            ApiService().backEndServerUrl + "/api/chat/${widget.ticket.id}",
          ),
          headers: {
            'Cookie': 'JSESSIONID=${session.cookies}',
            'Content-type': 'application/json'
          },
          body: json.encode({'message': message}));

      if (response.statusCode == 200) {
        setState(() {
          _messages.add(ChatMessage(message: message, admin: isAdmin));
          _textController.clear();
        });
      } else {
        throw Exception('Failed to send message');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkIfUserIsAdmin() async {
    return BudgetJsonService().getUser().then((user) {
      if (user.role == "ADMIN") {
        setState(() {
          isAdmin = true;
        });
      } else {
        setState(() {
          isAdmin = false;
        });
      }
    });
  }

  Container createMessage(TextEditingController editingController) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                key: formKey,
                child: TextFormField(
                  minLines: 1,
                  maxLines: null,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a messager';
                    } else
                      return null;
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(255, 49, 49, 51),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 49, 49, 51)),
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Enter your message here',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    sendMessage(_textController.text);
                    _textController.clear();
                    setState(() {});
                  }
                },
                child: Text(
                  'SEND',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
