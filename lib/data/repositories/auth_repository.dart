import 'package:payment_app/services/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository(this.authService);

  Future<String?> singIn({
    required String email,
    required String password,
  }) async {
    return await authService.signIn(
      email: email,
      password: password,
    );
  }

  Future<String?> singUp({
    required String name,
    required String email,
    required String password,
  }) async {
    return await authService.signUp(
      name: name,
      email: email,
      password: password,
    );
  }

  Future<void> singOut() async {
    await authService.signOut();
  }

  Future<String?> getUserIdFromPreferences() async {
    return await authService.getUserIdFromPreferences();
  }
}
