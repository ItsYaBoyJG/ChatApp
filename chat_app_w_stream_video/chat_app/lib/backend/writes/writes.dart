import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class DbWrites {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  /// create userprofile data (username, first, last), saves info meant to be kepts
  /// private.
  void saveUserProfile(String uId, String userName, String first, String last) {
    _firebaseFirestore.collection('profileData').doc(uId).set(
        {'userName': userName, 'first': first, 'last': last, 'groups': []});
  }

  /// update userprofile data (username, first, last)
  void updateUserProfile(
      String uId, String userName, String first, String last) {
    _firebaseFirestore
        .collection('profileData')
        .doc(uId)
        .update({'userName': userName, 'first': first, 'last': last});
  }

  void addGroupIdToUserProfileData(String uId, String groupId) {
    _firebaseFirestore.collection('profileData').doc(uId).update({
      'groups': [groupId]
    });
  }

  /// start message thread with user using FirebaseChatCore
  /// receives PartialText from Chat Widget (MessagesView)
  void addMessageToThread(PartialText message, Room room) {
    FirebaseChatCore.instance.sendMessage(message, room.id);
  }

  /// Creates the (FirebaseChatCore) Room that a user is apart of
  /// and the other user that belongs to that room
  Future<void> createSingleRoom(User otherUser) async {
    await FirebaseChatCore.instance.createRoom(otherUser);
  }

  /// this is used to update each group's most recent message and to help with
  /// filtering the list of group message threads
  void updateGroupRecentMessage(Room room) {
    FirebaseChatCore.instance.updateRoom(room);
  }

  /// create user info for referencing for chat id, group id, user name, first
  void createUser(String uId, String userName, String first, String last) {
    _firebaseFirestore
        .collection('users')
        .doc(userName)
        .set({'first': first, 'last': last, 'uId': uId, 'userName': userName});
  }

  /// add selected user to friends list
  void addUserToFriendsList(String uId, User user) {
    _firebaseFirestore
        .collection('userFriendsList')
        .doc(uId)
        .collection('friends')
        .add(User(
                id: user.id, firstName: user.firstName, lastName: user.lastName)
            .toJson());
  }

  void saveUserStreamVideoCredential(
      String uId, String streamApiUserId, String streamApiUserToken) {
    _firebaseFirestore.collection('userVideoCredential').doc(uId).set({
      'userToken': streamApiUserToken,
      'userId': streamApiUserId,
    });
  }

  /// remove selected user from friends list

  /// add selected user to following list

  /// remove selected user from following list
}
