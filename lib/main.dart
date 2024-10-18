import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapefalso/presentation/contact_search/contact_search_page.dart';
import 'package:yapefalso/presentation/payments_history/all_payment_history.dart';
import 'package:yapefalso/presentation/payments_history/payments_history_page.dart';
import 'package:yapefalso/presentation/qr/qr_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const ContactSearchPage(),
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(63, 13, 74, 1),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color.fromRGBO(192, 192, 192, 1),
                    textStyle: const TextStyle(fontSize: 30)))));
  }
}
