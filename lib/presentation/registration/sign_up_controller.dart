import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/data/auth.dart';
import 'package:yapefalso/presentation/registration/password_registration_controller.dart';
import 'package:yapefalso/presentation/registration/user_registration_data_controller.dart';

part 'sign_up_controller.g.dart';

@riverpod
class SignUp extends _$SignUp {
  @override
  FutureOr<void> build() {}

  Future<void> signUp() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      var password = ref.read(passwordCreationProvider.notifier).parseList();
      var userData = ref.read(userRegistrationDataProvider);
      await ref.read(authenticationProvider).signUp(
            email: userData.email,
            password: password,
            userData: userData,
          );
    });
  }
}
