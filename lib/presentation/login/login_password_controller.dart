import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/presentation/login/sign_in_controller.dart';

part 'login_password_controller.g.dart';

@riverpod
class Password extends _$Password {
  @override
  List<int> build() {
    return [];
  }

  void increment(int value, String email) async {
    if (length < 6) {
      state = [...state, value];
    }
    if (length == 6) {
      await ref.read(signInProvider.notifier).signIn(
          email: email,
          password: ref.read(passwordProvider.notifier).parseList());
    }
  }

  void decrease() {
    state = [
      for (var value = 0; value < state.length - 1; value++) state[value],
    ];
  }

  String parseList() {
    var password = '';
    for (var value = 0; value < state.length; value++) {
      password = password + state[value].toString();
    }
    return password;
  }

  int get length => state.length;
}
