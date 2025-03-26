import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:nerosoft_app/common/utils/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiInterceptor implements InterceptorContract {
  final SharedPreferencesAsync sharedPrefLocal;

  ApiInterceptor({required this.sharedPrefLocal});

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    try {
      final token = await sharedPrefLocal.getString('token');

      request.headers[HttpHeaders.contentTypeHeader] = "application/json";
      request.headers[HttpHeaders.authorizationHeader] = "Bearer $token";

      return request;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  FutureOr<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    try {
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }
}

class ApiInterceptorNotifier extends Notifier<ApiInterceptor> {
  @override
  ApiInterceptor build() {
    final sharedprefLocal = ref.read(sharedPrefLocalProvider);

    return ApiInterceptor(sharedPrefLocal: sharedprefLocal.asncPrefs);
  }

  Client getClientInterceptor() {
    Client client = InterceptedClient.build(interceptors: [
      state,
    ]);
    return client;
  }
}

final apiInterceptorProvider =
    NotifierProvider<ApiInterceptorNotifier, ApiInterceptor>(() {
  return ApiInterceptorNotifier();
});
