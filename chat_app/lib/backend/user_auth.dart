import 'package:chat_app/backend/writes.dart';
import 'package:chat_app/models/user/user_video_creds.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chattypes;
import 'package:stream_video/stream_video.dart' as stream
    show UserInfo, UserToken;

class UserAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DbWrites _dbWrites = DbWrites();

  String getUserId() {
    return _firebaseAuth.currentUser!.uid;
  }

  void userSignIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  void registerUser(
      String email, String password, String firstName, String lastName) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((onValue) {
      final userInfo = stream.UserInfo(id: onValue.user!.uid);
      final userToken = stream.UserToken.jwt(onValue.user!.uid);

      _dbWrites.saveUserStreamVideoCredential(onValue.user!.uid,
          UserVideoCredentials(userInfo: userInfo, userToken: userToken));
      createUserForChat(firstName, lastName);
    });
  }

  void createUserForChat(String firstName, String lastName) async {
    final id = getUserId();
    print('got here');
    await FirebaseChatCore.instance.createUserInFirestore(
        chattypes.User(id: id, firstName: firstName, lastName: lastName));
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
