import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat/app/constants/app_string.dart';
import 'package:flutter_chat/app/modules/chat/services/chat_notification_service.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.notificationPageAppBar),
      ),
      body: ListView.builder(
        itemCount: service.itemsCount,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(items[index].title),
          subtitle: Text(items[index].body),
          onTap: () => service.remove(index),
        ),
      ),
    );
  }
}
