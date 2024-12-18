import 'package:chat_app/backend/auth/user_auth.dart';
import 'package:chat_app/backend/futures/futures.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProfileDataProvider = FutureProvider((ref) {
  UserAuth userAuth = UserAuth();
  DbFutures dbFutures = DbFutures();
  return dbFutures.getUserProfileData(userAuth.getUserId());
});
