import 'package:cloud_firestore/cloud_firestore.dart';

class DbFutures {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getPublicUsers() {
    return _firebaseFirestore.collection('users').get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserFriends(String uId) {
    return _firebaseFirestore
        .collection('userFriends')
        .doc(uId)
        .collection('friends')
        .get();
  }

  checkIfGroupExists(String uId, String friendId) {
//    final group = _firebaseFirestore.collection('groups').doc()
  }

  Future<bool> currentAndOtherUserExistInGroup(
      String uId, String otherId) async {
    final doc = _firebaseFirestore
        .collection('groups')
        .where('members', arrayContains: uId)
        .where('members', arrayContains: otherId)
        .snapshots();
    if (await doc.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileData(
      String uId) {
    return _firebaseFirestore.collection('profileData').doc(uId).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>
      getUserStreamVideoApiCredentials(String uId) {
    return _firebaseFirestore.collection('userVideoCredential').doc(uId).get();
  }
}
