import 'dart:math';
import 'dart:async';
import 'chat_service.dart';
import '../models/chat_message_model.dart';
import '../../authentication/models/chat_user_model.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessageModel> _messages = [];

  static MultiStreamController<List<ChatMessageModel>>? _controller;

  static final _messagesStream =
      Stream<List<ChatMessageModel>>.multi((controller) {
    _controller = controller;
    controller.add(_messages);
  });

  @override
  Stream<List<ChatMessageModel>> messagesStream() => _messagesStream;

  @override
  Future<ChatMessageModel> save(String text, ChatUserModel user) async {
    final _newMessage = ChatMessageModel(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    _messages.add(
      _newMessage,
    );

    _controller?.add(_messages.reversed.toList());
    return _newMessage;
  }
}
