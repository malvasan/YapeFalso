import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';

part 'password_registration_controller.g.dart';

@riverpod
class PasswordCreation extends _$PasswordCreation {
  @override
  List<int> build() {
    return [];
  }

  void increment(int value) {
    if (length >= 6) {
      ref.read(autorouteProvider).push(const AccountTypeSelectionRoute());
    }
    state = [...state, value];
  }

  void decrease() {
    state = [
      for (var value = 0; value < state.length - 1; value++) value,
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
