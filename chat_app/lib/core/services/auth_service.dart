import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat_types;

abstract class AuthService {
  User? get currentUser;
  String? get currentUserId;
  Stream<User?> get authStateChanges;
  
  Future<UserCredential> signInWithEmailAndPassword(String email, String password);
  Future<UserCredential> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<void> createChatUser(String firstName, String lastName);
}

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<void> createChatUser(String firstName, String lastName) async {
    final id = currentUserId;
    if (id == null) throw Exception('User not authenticated');
    
    await FirebaseChatCore.instance.createUserInFirestore(
      chat_types.User(id: id, firstName: firstName, lastName: lastName),
    );
  }
}