import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerosoft_app/common/utils/shared_preference.dart';
import 'package:nerosoft_app/features/auth/dto/auth_response.dart';
import 'package:nerosoft_app/features/auth/models/auth_model.dart';

class AuthResponseNotifier extends AutoDisposeAsyncNotifier<AuthResponse> {
  static const USER = 'user';
  static const PASSWORD = 'password';

  @override
  FutureOr<AuthResponse> build() async {
    final authResponse = await handleInitialAuth();

    return authResponse;
  }

  Future<AuthResponse> handleInitialAuth() async {
    final pref = ref.read(sharedPrefLocalProvider);

    final uid = await pref.asncPrefs.getString(USER);
    final password = await pref.asncPrefs.getString(PASSWORD);

    final user = uid != null && password != null
        ? AuthModel(uid: int.parse(uid), password: password)
        : null;

    return AuthResponse(auth: user);
  }

  Future<void> setResponse(AuthResponse response) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await setUser(response);

      final newResponse = await handleInitialAuth();
      return newResponse;
    });
  }

  Future<void> logout() async {
    final pref = ref.read(sharedPrefLocalProvider);

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await pref.asncPrefs.clear();

      final newResponse = await handleInitialAuth();
      return newResponse;
    });
  }

  Future<void> setUser(AuthResponse response) async {
    final pref = ref.read(sharedPrefLocalProvider);
    await pref.asncPrefs.setString(USER, response.auth!.uid.toString());
    await pref.asncPrefs.setString(PASSWORD, response.auth!.password);
  }
}

final authResponseProvider =
    AutoDisposeAsyncNotifierProvider<AuthResponseNotifier, AuthResponse>(() {
  return AuthResponseNotifier();
});
