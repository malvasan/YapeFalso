import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/domain/user_metadata.dart';

part 'user_registration_data_controller.g.dart';

@Riverpod(keepAlive: true)
class UserRegistrationData extends _$UserRegistrationData {
  @override
  UserMetadata build() {
    return const UserMetadata(
      id: '',
      accountNumber: '',
      credit: 0.0,
      dni: 0,
      email: '',
      name: '',
      phoneNumber: 0,
    );
  }

  void updatePhoneNumber(int newPhone) {
    state = state.copyWith(phoneNumber: newPhone);
  }

  void updatePersonalInformation({
    required String newName,
    required String newEmail,
    required int newDNI,
  }) {
    state = state.copyWith(email: newEmail, dni: newDNI, name: newName);
  }

  void updateAccountNumber(String newAccountNumber) {
    state = state.copyWith(accountNumber: newAccountNumber);
  }
}
