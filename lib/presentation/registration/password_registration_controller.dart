import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_registration_controller.g.dart';

@riverpod
class PasswordCreation extends _$PasswordCreation {
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
    }
  }

  void decrease() {
    state = [
      for (var value = 0; value < state.length - 1; value++) value,
    ];
  }

  int get length => state.length;
}
