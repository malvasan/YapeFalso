import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';
import 'package:yapefalso/presentation/appStartup/app_startup.dart';
import 'package:yapefalso/utils.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const supabaseUrl = 'https://dwcurxogbbsqjuagfuch.supabase.co';

  await Supabase.initialize(
      url: supabaseUrl,
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR3Y3VyeG9nYmJzcWp1YWdmdWNoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEwODU1NTIsImV4cCI6MjA0NjY2MTU1Mn0.OE9ywfv_vuQynhj42gQN0BaUiqJ5LXacDh3GcWZIwG0');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(autorouteProvider);

    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: mainColor,
        ),
        primaryColor: mainColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: const Color.fromRGBO(192, 192, 192, 1),
            textStyle: const TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
      routerConfig: appRouter.config(),
      builder: (context, child) {
        return AppStartupWidget(
          onLoaded: (context) => child!,
        );
      },
    );
  }
}
