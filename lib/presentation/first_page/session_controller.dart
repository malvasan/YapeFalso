import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_controller.g.dart';

@Riverpod(keepAlive: true)
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
