import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yapefalso/data/messaging.dart';
import 'package:yapefalso/domain/user_metadata.dart';
import 'package:yapefalso/presentation/first_page/session_controller.dart';

part 'auth.g.dart';

class Auth {
  const Auth(this.supabase, this.ref);

  final SupabaseClient supabase;
  final Ref ref;

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
      ref.read(authenticationStateProvider.notifier).isLoggedIn();

      final messaging = ref.read(messagingProvider);
      final fcmToken = await messaging.getToken();
      if (fcmToken != null) {
        await setFcmToken(fcmToken);
      }
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
      ref.read(authenticationStateProvider.notifier).isLoggedIn();

      final messaging = ref.read(messagingProvider);
      final fcmToken = await messaging.getToken();
      if (fcmToken != null) {
        await setFcmToken(fcmToken);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      ref.read(authenticationStateProvider.notifier).isLoggedOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> setFcmToken(String fcmToken) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId != null) {
      await Supabase.instance.client.from('profiles').upsert({
        'id': userId,
        'fcm_token': fcmToken,
      });
    }
  }
}

@Riverpod(keepAlive: true)
Auth authentication(AuthenticationRef ref) {
  return Auth(Supabase.instance.client, ref);
}
