import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/data/data_base_repository.dart';
import 'package:yapefalso/domain/user_metadata.dart';

part 'user_transfer_controller.g.dart';

@riverpod
Future<UserMetadata> userTransfer(UserTransferRef ref,
    {required int phone}) async {
  return ref.watch(dataBaseProvider).retrieveUserByPhone(phone);
}
