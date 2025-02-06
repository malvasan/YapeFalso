import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';
import 'package:yapefalso/data/auth.dart';
import 'package:yapefalso/presentation/login/biometric_controller.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignIn extends _$SignIn {
  @override
  FutureOr<void> build() {}

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(authenticationProvider)
          .signIn(email: email, password: password);
      ref.read(biometricProvider.notifier).cancelAuth();
      await ref.read(autorouteProvider).replaceAll([
        const PaymentsRoute(),
      ]);
    });
  }
}
