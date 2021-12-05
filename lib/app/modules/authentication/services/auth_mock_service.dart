import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'auth_service.dart';
import '../models/chat_user_model.dart';

class AuthMockService implements AuthService {
  static final _defaultUser = ChatUserModel(
    id: '10',
    name: 'Test',
    email: 'test@email.com.br',
    imageUrl: 'assets/images/avatar.png',
  );

  static final Map<String, ChatUserModel> _users = {
    _defaultUser.email: _defaultUser,
  };
  static ChatUserModel? _currentUser;
  static MultiStreamController<ChatUserModel?>? _controller;
  static final _userStrema = Stream<ChatUserModel?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  @override
  ChatUserModel? get currentUser {
    return _currentUser;
  }

  @override
  Future<void> logOut() async {
    _updateUser(null);
  }

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> signUp(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUserModel(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? '/assets/images/',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  @override
  Stream<ChatUserModel?> get userChanges => _userStrema;

  static void _updateUser(ChatUserModel? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
