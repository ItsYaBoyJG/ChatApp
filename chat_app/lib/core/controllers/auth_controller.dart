import 'package:chat_app/core/providers/service_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthController {
  final Ref ref;

  AuthController(this.ref);

  Future<void> signIn(String email, String password) async {
    final authService = ref.read(authServiceProvider);
    await authService.signInWithEmailAndPassword(email, password);
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? userName,
  }) async {
    final authService = ref.read(authServiceProvider);
    final userService = ref.read(userServiceProvider);
    final videoService = ref.read(videoServiceProvider);

    final userCredential = await authService.createUserWithEmailAndPassword(email, password);
    final userId = userCredential.user!.uid;

    // Generate video credentials
    final videoCredentials = videoService.generateVideoCredentials(userId);

    // Save all user data
    await Future.wait([
      videoService.saveUserVideoCredentials(userId, videoCredentials),
      authService.createChatUser(firstName, lastName),
      if (userName != null)
        userService.saveUserProfile(userId, userName, firstName, lastName),
    ]);
  }

  Future<void> signOut() async {
    final authService = ref.read(authServiceProvider);
    await authService.signOut();
  }
}

final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(ref);
});