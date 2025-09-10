import 'package:chat_app/models/user/user_model.dart';
import 'package:chat_app/models/user/user_video_creds.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

abstract class UserService {
  Future<UserProfile> getUserProfile(String userId);
  Future<void> saveUserProfile(String userId, String userName, String firstName, String lastName);
  Future<void> updateUserProfile(String userId, String userName, String firstName, String lastName);
  Future<void> saveUserVideoCredentials(String userId, UserVideoCredentials credentials);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserVideoCredentials(String userId);
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserFriendsStream(String userId);
  Future<void> addUserToFriendsList(String userId, User user);
  Future<QuerySnapshot<Map<String, dynamic>>> getPublicUsers();
}

class FirestoreUserService implements UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserProfile> getUserProfile(String userId) async {
    final doc = await _firestore.collection('profileData').doc(userId).get();
    final data = doc.data();
    if (data == null) throw Exception('User profile not found');
    return UserProfile.fromJson(data);
  }

  @override
  Future<void> saveUserProfile(String userId, String userName, String firstName, String lastName) {
    return _firestore.collection('profileData').doc(userId).set({
      'userName': userName,
      'first': firstName,
      'last': lastName,
      'groups': [],
    });
  }

  @override
  Future<void> updateUserProfile(String userId, String userName, String firstName, String lastName) {
    return _firestore.collection('profileData').doc(userId).update({
      'userName': userName,
      'first': firstName,
      'last': lastName,
    });
  }

  @override
  Future<void> saveUserVideoCredentials(String userId, UserVideoCredentials credentials) {
    return _firestore.collection('userVideoCredential').doc(userId).set(credentials.toJson());
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserVideoCredentials(String userId) {
    return _firestore.collection('userVideoCredential').doc(userId).get();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserFriendsStream(String userId) {
    return _firestore
        .collection('userFriendsList')
        .doc(userId)
        .collection('friends')
        .snapshots();
  }

  @override
  Future<void> addUserToFriendsList(String userId, User user) {
    return _firestore
        .collection('userFriendsList')
        .doc(userId)
        .collection('friends')
        .add(User(
          id: user.id,
          firstName: user.firstName,
          lastName: user.lastName,
        ).toJson());
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getPublicUsers() {
    return _firestore.collection('users').get();
  }
}