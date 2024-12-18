import 'package:cloud_firestore/cloud_firestore.dart';

class DbStreams {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> userGroupsStream(String uId) {
    final groupRef = _firebaseFirestore.collection('groups');
    return groupRef
        .where('members', arrayContains: uId)
        .orderBy('recentMessage')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> groupThreadMessagesStream(
      String groupId) {
    return _firebaseFirestore
        .collection('messageThread')
        .doc(groupId)
        .collection('messages')
        .orderBy('sentAt')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userFriendsStream(String uId) {
    return _firebaseFirestore
        .collection('userFriendsList')
        .doc(uId)
        .collection('friends')
        .snapshots();
  }
}
