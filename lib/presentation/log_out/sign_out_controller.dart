import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/data/auth.dart';
import 'package:yapefalso/presentation/appStartup/app_startup_controller.dart';

part 'sign_out_controller.g.dart';

@riverpod
class SignOut extends _$SignOut {
  @override
  FutureOr<void> build() {}

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.watch(sharedPreferencesProvider).requireValue;
      final FlutterSecureStorage storage = const FlutterSecureStorage();
      await prefs.remove('qr');
      await prefs.remove('email');
      await storage.deleteAll();
      await ref.read(authenticationProvider).signOut();
    });
  }
}
