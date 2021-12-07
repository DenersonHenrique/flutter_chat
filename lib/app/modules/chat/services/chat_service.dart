import 'chat_firebase_service.dart';
import '../models/chat_message_model.dart';
import '../../authentication/models/chat_user_model.dart';

abstract class ChatService {
  Stream<List<ChatMessageModel>> messagesStream();
  Future<ChatMessageModel?> save(String text, ChatUserModel user);

  factory ChatService() => ChatFirebaseService();
}
