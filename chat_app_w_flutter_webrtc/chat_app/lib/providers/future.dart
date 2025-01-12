import 'package:chat_app/backend/user_auth.dart';
import 'package:chat_app/backend/futures.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProfileDataProvider = FutureProvider((ref) {
  UserAuth userAuth = UserAuth();
  DbFutures dbFutures = DbFutures();
  return dbFutures.getUserProfileData(userAuth.getUserId());
});
