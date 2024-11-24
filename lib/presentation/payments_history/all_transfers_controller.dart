import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/data/data_base_repository.dart';
import 'package:yapefalso/domain/transfer.dart';

part 'all_transfers_controller.g.dart';

@riverpod
Future<List<Transfer>> transfersFiltered(TransfersFilteredRef ref,
    {required DateTime date}) async {
  return ref.watch(dataBaseProvider).retrieveTransfersByDate(date);
}
