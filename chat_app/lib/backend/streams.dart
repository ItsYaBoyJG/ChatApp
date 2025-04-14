import 'package:cloud_firestore/cloud_firestore.dart';

class DbStreams {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> userFriendsStream(String uId) {
    return _firebaseFirestore
        .collection('userFriendsList')
        .doc(uId)
        .collection('friends')
        .snapshots();
  }
}
