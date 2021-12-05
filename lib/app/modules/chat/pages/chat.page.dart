import 'package:flutter/material.dart';
import '../widgets/messages_widget.dart';
import '../widgets/new_message_widget.dart';
import '../../authentication/services/auth_service.dart';
import 'package:flutter_chat/app/constants/app_string.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.chatPageAppBar),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.exit_to_app,
                      color: Colors.black87,
                    ),
                    const SizedBox(width: 10),
                    Text(AppString.exitLabel),
                  ],
                ),
              )
            ],
            onChanged: (value) {
              if (value == 'logout') {
                AuthService().logOut();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: const <Widget>[
            Expanded(
              child: MessagesWidget(),
            ),
            NewMessageWidget(),
          ],
        ),
      ),
    );
  }
}
