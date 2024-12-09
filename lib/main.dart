import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yapefalso/autoroute/autoroute.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const supabaseUrl = 'https://dwcurxogbbsqjuagfuch.supabase.co';
  //const supabaseKey = String.fromEnvironment('SUPABASE_KEY');
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR3Y3VyeG9nYmJzcWp1YWdmdWNoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEwODU1NTIsImV4cCI6MjA0NjY2MTU1Mn0.OE9ywfv_vuQynhj42gQN0BaUiqJ5LXacDh3GcWZIwG0',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF742284),
        ),
        primaryColor: const Color(0xFF742284),
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
      routerConfig: _appRouter.config(),
    );
  }
}
