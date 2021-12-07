import 'dart:async';
import 'chat_service.dart';
import '../models/chat_message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../authentication/models/chat_user_model.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessageModel>> messagesStream() =>
      const Stream<List<ChatMessageModel>>.empty();

  @override
  Future<ChatMessageModel?> save(String text, ChatUserModel user) async {
    final store = FirebaseFirestore.instance;
    final docRef = await store.collection('chat').add({
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': user.id,
      'userName': user.name,
      'userImageUrl': user.imageUrl,
    });

    final doc = await docRef.get();
    final data = doc.data()!;

    return ChatMessageModel(
      id: doc.id,
      text: data['text'],
      createdAt: DateTime.parse(data['createdAt']),
      userId: data['userId'],
      userName: data['userName'],
      userImageUrl: data['userImageUrl'],
    );
  }
}
