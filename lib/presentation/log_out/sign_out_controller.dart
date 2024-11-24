import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/data/auth.dart';

part 'sign_out_controller.g.dart';

@riverpod
class SignOut extends _$SignOut {
  @override
  FutureOr<void> build() {}

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authenticationProvider).signOut();
    });
  }
}
