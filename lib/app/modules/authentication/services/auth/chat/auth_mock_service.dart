import 'dart:io';
import 'auth_service.dart';
import '../../../models/chat_user.dart';

class AuthMockService implements AuthService {
  static Map<String, ChatUser> _users = {};
  static ChatUser? _currentUser;

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Future<void> logOut() async {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> login(String email, String password) async {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(
    String name,
    String email,
    String password,
    File image,
  ) async {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  // TODO: implement userChanges
  Stream<ChatUser?> get userChanges => throw UnimplementedError();
}
