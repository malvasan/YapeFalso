import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yapefalso/domain/user_metadata.dart';

part 'auth.g.dart';

class Auth {
  const Auth(this.supabase);

  final SupabaseClient supabase;

  Future<void> signUp({
    required String email,
    required String password,
    required UserMetadata userData,
  }) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: userData.toJson(),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

@Riverpod(keepAlive: true)
Auth authentication(AuthenticationRef ref) {
  return Auth(Supabase.instance.client);
}
