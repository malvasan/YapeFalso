import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'session_controller.g.dart';

@riverpod
Stream<AuthState> authenticationState(AuthenticationStateRef ref) {
  final supabase = Supabase.instance.client;

  return supabase.auth.onAuthStateChange;
}
