import 'dart:io';
import 'auth_mock_service.dart';
import 'auth_firebase_service.dart';
import '../models/chat_user_model.dart';

abstract class AuthService {
  ChatUserModel? get currentUser;

  Stream<ChatUserModel?> get userChanges;

  Future<void> signUp(
    String name,
    String email,
    String password,
    File? image,
  );

  Future<void> login(String email, String password);

  Future<void> logOut();

  factory AuthService() => AuthFirebaseService();
}
