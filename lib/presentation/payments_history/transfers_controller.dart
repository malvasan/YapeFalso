import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/data/data_base_repository.dart';
import 'package:yapefalso/domain/transfer.dart';

part 'transfers_controller.g.dart';

@riverpod
Future<List<Transfer>> transfers(TransfersRef ref) async {
  return ref.watch(dataBaseProvider).retrieveTransfers();
}
