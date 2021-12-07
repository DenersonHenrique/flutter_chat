import 'dart:async';
import 'chat_service.dart';
import '../models/chat_message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../authentication/models/chat_user_model.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessageModel>> messagesStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots();

    return Stream<List<ChatMessageModel>>.multi((controller) {
      snapshots.listen((snapshot) {
        List<ChatMessageModel> list =
            snapshot.docs.map((doc) => doc.data()).toList();
        controller.add(list);
      });
    });
  }

  @override
  Future<ChatMessageModel?> save(String text, ChatUserModel user) async {
    final store = FirebaseFirestore.instance;

    final message = ChatMessageModel(
      id: '',
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    final docRef = await store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(message);

    final doc = await docRef.get();
    return doc.data()!;
  }

  Map<String, dynamic> _toFirestore(
    ChatMessageModel message,
    SetOptions? options,
  ) =>
      {
        'text': message.text,
        'createdAt': message.createdAt.toIso8601String(),
        'userId': message.userId,
        'userName': message.userName,
        'userImageUrl': message.userImageUrl,
      };

  ChatMessageModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) =>
      ChatMessageModel(
        id: doc.id,
        text: doc['text'],
        createdAt: DateTime.parse(doc['createdAt']),
        userId: doc['userId'],
        userName: doc['userName'],
        userImageUrl: doc['userImageUrl'],
      );
}
