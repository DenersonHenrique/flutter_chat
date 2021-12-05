import 'dart:math';
import 'dart:async';
import 'chat_service.dart';
import '../models/chat_message_model.dart';
import '../../authentication/models/chat_user_model.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessageModel> _messages = [
    ChatMessageModel(
      id: '1',
      text: 'Olá!',
      createdAt: DateTime.now(),
      userId: '50',
      userName: 'DeninTeste',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessageModel(
      id: '2',
      text: 'Oi Denin',
      createdAt: DateTime.now(),
      userId: '10',
      userName: 'Denerson',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessageModel(
      id: '3',
      text: 'Tudo certo com Flutter? Muitos Apps?',
      createdAt: DateTime.now(),
      userId: '50',
      userName: 'DeninTeste',
      userImageUrl: 'assets/images/avatar.png',
    ),
  ];

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

    _controller?.add(_messages);
    return _newMessage;
  }
}
