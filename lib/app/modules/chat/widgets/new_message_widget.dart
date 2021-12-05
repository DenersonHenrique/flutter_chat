import 'package:flutter/material.dart';
import 'package:flutter_chat/app/constants/app_string.dart';
import 'package:flutter_chat/app/modules/chat/services/chat_service.dart';
import 'package:flutter_chat/app/modules/authentication/services/auth_service.dart';

class NewMessageWidget extends StatefulWidget {
  const NewMessageWidget({Key? key}) : super(key: key);

  @override
  State<NewMessageWidget> createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  String _message = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      await ChatService().save(_message, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (message) => setState(() => _message = message),
            decoration: InputDecoration(
              labelText: AppString.sendMessage,
            ),
          ),
        ),
        IconButton(
          onPressed: _message.trim().isEmpty ? null : _sendMessage,
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
