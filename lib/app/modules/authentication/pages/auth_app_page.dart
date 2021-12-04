import 'chat.page.dart';
import 'auth_page.dart';
import '../models/chat_user.dart';
import 'package:flutter/material.dart';
import '../../../common/pages/loading_page.dart';
import '../services/auth/chat/auth_service.dart';

class AuthAppPage extends StatelessWidget {
  const AuthAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthService().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return snapshot.hasData ? const ChatPage() : const AuthPage();
          }
        },
      ),
    );
  }
}
