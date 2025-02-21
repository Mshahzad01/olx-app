import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_model.dart';

final authStateProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  AuthNotifier() : super(const AsyncValue.data(null));

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      // Implement sign in logic
      state = AsyncValue.data(UserModel(
        id: '1',
        name: 'Test User',
        email: email,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      // Implement sign up logic
      state = AsyncValue.data(UserModel(
        id: '1',
        name: name,
        email: email,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
