import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapefalso/autoroute/autoroute.dart';

part 'autoroute_provider.g.dart';

@Riverpod(keepAlive: true)
AppRouter autoroute(AutorouteRef ref) {
  return AppRouter();
}
