import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class Password extends _$Password {
  @override
  List<int> build() {
    return [];
  }

  void increment(int value) {
    state = [...state, value];
    //TODO: authentication
  }

  void decrease() {
    state = [
      for (var value = 0; value < state.length - 1; value++) value,
    ];
  }

  int get length => state.length;
}
