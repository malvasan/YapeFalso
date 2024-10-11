import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapefalso/presentation/login/login_page.dart';
import 'package:yapefalso/presentation/payments/payments_page.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const PaymentsPage(),
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
