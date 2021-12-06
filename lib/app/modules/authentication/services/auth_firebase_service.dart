import 'dart:io';
import 'dart:async';
import 'auth_service.dart';
import '../models/chat_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthFirebaseService implements AuthService {
  static ChatUserModel? _currentUser;

  static final _userStrema = Stream<ChatUserModel?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUserModel(user);
      controller.add(_currentUser);
    }
  });

  @override
  ChatUserModel? get currentUser {
    return _currentUser;
  }

  @override
  Future<void> logOut() async => FirebaseAuth.instance.signOut();

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signUp(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) return;

    // 1. Upload user image
    final imageName = '${credential.user!.uid}.png';
    final imageUrl = await _uploadUserImage(image, imageName);

    // 2. Update user properties
    credential.user?.updateDisplayName(name);
    credential.user?.updatePhotoURL(imageUrl);
  }

  @override
  Stream<ChatUserModel?> get userChanges => _userStrema;

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image!).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  static ChatUserModel _toChatUserModel(User user) => ChatUserModel(
        id: user.uid,
        name: user.displayName ?? user.email!.split('@')[0],
        email: user.email!,
        imageUrl: user.photoURL ?? 'assets/images/avatar.png',
      );
}
