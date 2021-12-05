import 'package:flutter/material.dart';
import 'package:flutter_chat/app/modules/chat/models/chat_notification_model.dart';
import 'package:flutter_chat/app/modules/chat/pages/notification_page.dart';
import 'package:provider/provider.dart';
import '../widgets/messages_widget.dart';
import '../widgets/new_message_widget.dart';
import '../../../constants/app_string.dart';
import '../services/chat_notification_service.dart';
import '../../authentication/services/auth_service.dart';

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
          DropdownButtonHideUnderline(
            child: DropdownButton(
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
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const NotificationPage(),
                  ),
                ),
                icon: const Icon(Icons.notifications),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    '${Provider.of<ChatNotificationService>(context).itemsCount}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              )
            ],
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Provider.of<ChatNotificationService>(
          context,
          listen: false,
        ).add(
          ChatNotificationModel(title: 'title', body: 'body'),
        ),
      ),
    );
  }
}
