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

      final uid = await xml_rpc.call(loginUri, 'authenticate',
          [Api.databaseIns, username, password, response]);

      final authResponse = uid as int;

      final result = AuthResponse(auth: AuthModel(uid: authResponse));

      ref.read(authResponseProvider.notifier).setResponse(result);
    } on Exception catch (err) {
      print(err);
      throw Exception(err.toString());
    }
  }
}

final authServiceProvider =
    AutoDisposeNotifierProvider<AuthService, AsyncValue<dynamic>>(() {
  return AuthService();
});
