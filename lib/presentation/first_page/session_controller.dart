import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_controller.g.dart';

@riverpod
class AuthenticationState extends _$AuthenticationState {
  @override
  bool build() {
    return false;
  }

  void isLoggedIn() {
    state = true;
  }

  void isLoggedOut() {
    state = false;
  }
}

// @riverpod
// bool authenticationState(AuthenticationStateRef ref) {
//   return false;
// }
