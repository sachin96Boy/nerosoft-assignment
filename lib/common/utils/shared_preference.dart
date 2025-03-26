import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceLocal {
  final SharedPreferencesAsync asncPrefs = SharedPreferencesAsync();
}

final sharedPrefLocalProvider = Provider<SharedPreferenceLocal>((ref) {
  final pref = SharedPreferenceLocal();
  return pref;
});
