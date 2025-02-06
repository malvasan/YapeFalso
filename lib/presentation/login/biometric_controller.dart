import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'biometric_controller.g.dart';

@riverpod
class Biometric extends _$Biometric {
  @override
  bool build() {
    return false;
  }

  void cancelAuth() {
    state = false;
  }

  void startAuth() {
    state = true;
  }
}
