import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/data/data_base_repository.dart';

part 'user_credit_controller.g.dart';

@riverpod
Future<double> credit(CreditRef ref) async {
  return ref.watch(dataBaseProvider).retrieveUserCredit();
}
