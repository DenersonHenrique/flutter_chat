import 'message_bubble_widget.dart';
import 'package:flutter/material.dart';
import '../services/chat_service.dart';
import '../models/chat_message_model.dart';
import '../../authentication/services/auth_service.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    return StreamBuilder<List<ChatMessageModel>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Sem mensagens. Vamos conversar?'),
          );
        } else {
          final messages = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) => MessageBubbleWidget(
              key: ValueKey(messages[index].id),
              message: messages[index],
              belongsToCurrentUser: currentUser?.id == messages[index].userId,
            ),
          );
        }
      },
    );
  }
}
