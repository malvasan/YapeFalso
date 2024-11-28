import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/data/data_base_repository.dart';
import 'package:yapefalso/domain/transfer.dart';

part 'payment_controller.g.dart';

@riverpod
class Payment extends _$Payment {
  @override
  FutureOr<Transfer?> build() {
    return null;
  }

  Future<void> payment(
      {required String userNote,
      required double amount,
      required String receiverID}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref
          .read(dataBaseProvider)
          .transfer(amount: amount, receiverID: receiverID, userNote: userNote);
    });
  }
}
