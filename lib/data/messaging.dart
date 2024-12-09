import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messaging.g.dart';

class MessagingRepository {
  MessagingRepository(this.firebaseMessaging);

  final FirebaseMessaging firebaseMessaging;

  Future<String?> getToken() async {
    await FirebaseMessaging.instance.requestPermission();

    await FirebaseMessaging.instance.getAPNSToken();

    return await FirebaseMessaging.instance.getToken();
  }
}

@Riverpod(keepAlive: true)
MessagingRepository messaging(MessagingRef ref) {
  return MessagingRepository(FirebaseMessaging.instance);
}
