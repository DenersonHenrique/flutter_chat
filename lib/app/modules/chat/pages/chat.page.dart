import 'package:flutter/material.dart';
import '../widgets/messages_widget.dart';
import '../widgets/new_message_widget.dart';
import '../../authentication/services/auth_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat flutter - Cod3r'),
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
                  children: const <Widget>[
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.black87,
                    ),
                    SizedBox(width: 10),
                    Text('Sair'),
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
