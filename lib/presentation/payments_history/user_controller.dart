import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/data/data_base_repository.dart';
import 'package:yapefalso/domain/user_metadata.dart';

part 'user_controller.g.dart';

@riverpod
Future<UserMetadata> user(UserRef ref) async {
  return ref.watch(dataBaseProvider).retrieveCurrentUser();
}
