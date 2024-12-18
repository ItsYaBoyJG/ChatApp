import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chattypes;

class UserAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String getUserId() {
    return _firebaseAuth.currentUser!.uid;
  }

  void userSignIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  void registerUser(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  void createUserForChat(String firstName, String lastName) async {
    final id = getUserId();
    await FirebaseChatCore.instance.createUserInFirestore(
        chattypes.User(id: id, firstName: firstName, lastName: lastName));
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
