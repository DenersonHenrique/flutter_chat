import 'auth_page.dart';
import '../services/auth_service.dart';
import 'package:flutter/material.dart';
import '../models/chat_user_model.dart';
import '../../chat/pages/chat.page.dart';
import '../../../common/pages/loading_page.dart';

class AuthAppPage extends StatelessWidget {
  const AuthAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUserModel?>(
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
