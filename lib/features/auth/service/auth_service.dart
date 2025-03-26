import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerosoft_app/common/utils/apis.dart';
import 'package:nerosoft_app/features/auth/dto/auth_response.dart';
import 'package:nerosoft_app/features/auth/models/auth_model.dart';
import 'package:nerosoft_app/features/auth/provider/auth_provider.dart';

import 'package:xml_rpc/client.dart' as xml_rpc;

class AuthService extends AutoDisposeNotifier<AsyncValue<dynamic>> {
  @override
  AsyncValue build() {
    return AsyncValue.data(null);
  }

  Future<void> signInWithUsernameAndPassword(
      String username, String password) async {
    try {
      final loginUri = Uri.parse(Api.login);

      final response = await xml_rpc.call(loginUri, 'version', []);

      final responsedata = await xml_rpc.call(loginUri, 'authenticate',
          [Api.databaseIns, username, password, response]);

      if (responsedata == false) {
        throw Exception("Invalid credentials");
      }

      final authResponse = responsedata as int;

      final result =
          AuthResponse(auth: AuthModel(uid: authResponse, password: password));

      ref.read(authResponseProvider.notifier).setResponse(result);
    } on Exception catch (err) {
      print(err);
      throw Exception(err.toString());
    }
  }

  Future<void> logout() async {
    await ref.read(authResponseProvider.notifier).logout();
  }
}

final authServiceProvider =
    AutoDisposeNotifierProvider<AuthService, AsyncValue<dynamic>>(() {
  return AuthService();
});
