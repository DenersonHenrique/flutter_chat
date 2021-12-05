import 'package:flutter/cupertino.dart';
import '../models/chat_notification_model.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotificationModel> _items = [];

  List<ChatNotificationModel> get items => [..._items];

  int get itemsCount => _items.length;

  void add(ChatNotificationModel notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
