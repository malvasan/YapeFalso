import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_password_controller.g.dart';

@riverpod
class Password extends _$Password {
  @override
  List<int> build() {
    return [];
  }

  void increment(int value) {
    if (length >= 6) {
      return;
    }
    state = [...state, value];
    if (length == 6) {
      log('call authentication');
      //TODO: authentication
    }
  }

  void decrease() {
    state = [
      for (var value = 0; value < state.length - 1; value++) value,
    ];
  }

  int get length => state.length;
}
