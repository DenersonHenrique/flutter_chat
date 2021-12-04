import 'package:flutter/material.dart';
import '../services/auth/chat/auth_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Chat page!'),
            TextButton(
              onPressed: () => AuthService().logOut(),
              child: const Text('LogOut'),
            ),
          ],
        ),
      ),
    );
  }
}
