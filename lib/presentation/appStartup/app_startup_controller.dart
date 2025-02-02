import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'app_startup_controller.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartup(AppStartupRef ref) async {
  ref.onDispose(() {
    // ensure we invalidate all the providers we depend on
    ref.invalidate(sharedPreferencesProvider);
  });
  // all asynchronous app initialization code should belong here:
  await ref.watch(sharedPreferencesProvider.future);
}

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) =>
    SharedPreferences.getInstance();
