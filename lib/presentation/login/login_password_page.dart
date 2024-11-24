import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/presentation/first_page/session_controller.dart';
import 'package:yapefalso/presentation/login/login_password_controller.dart';
import 'package:yapefalso/presentation/login/sign_in_controller.dart';

@RoutePage()
class LoginPasswordPage extends ConsumerWidget {
  const LoginPasswordPage({required this.email, super.key});
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final isLoading = ref.watch(signInProvider).isLoading;

    final signInProviderState = ref.watch(signInProvider);
    final isLoading = signInProviderState.isLoading;
    final isError = signInProviderState is AsyncError<void>;

    return Stack(children: [
      Scaffold(
        backgroundColor: const Color(0xFF4A1972),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            onPressed: () => context.router.maybePop(),
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.25, 1.0],
                    colors: [
                      Theme.of(context).primaryColor,
                      const Color(0xFF4A1972),
                    ],
                  ),
                ),
                child: Center(
                  child: Text('QR'),
                ),
              ),
            ),
            Flexible(flex: 2, child: PasswordSection(email: email)),
          ],
        ),
      ),
      Visibility(
        visible: isLoading,
        child: Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gap(10),
                  CircularProgressIndicator(),
                  Gap(10),
                  Text('Validando datos'),
                ],
              ),
            ),
          ),
        ),
      ),
      Visibility(
        visible: isError,
        child: Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(10),
                  const Text(
                    'Clave Incorrecta',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const Gap(5),
                  const Text(
                    'Después de 3 intentos incorrectos el\nacceso se bloqueará. En caso no\nrecuerdes tu clave, cámbiala.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const Gap(10),
                  TextButton(
                    onPressed: () {
                      ref.invalidate(signInProvider);
                    },
                    child: const Text(
                      'Intentar de nuevo',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFF2073E8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Gap(10),
                  TextButton(
                    onPressed: () {
                      ref.invalidate(signInProvider);
                    },
                    child: const Text(
                      'Cambiar clave',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFF2073E8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class PasswordSection extends StatelessWidget {
  const PasswordSection({required this.email, super.key});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          PasswordField(
            email: email,
          ),
          const Gap(20),
          Expanded(
            flex: 9,
            child: NumericPad(email: email),
          ),
        ],
      ),
    );
  }
}

class PasswordField extends ConsumerWidget {
  const PasswordField({required this.email, super.key});
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      authenticationStateProvider,
      (_, state) => state.whenOrNull(
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
        data: (data) {
          final event = data.event;

          if (event == AuthChangeEvent.signedIn) {
            context.router.push(const PaymentsRoute());
          }
        },
      ),
    );

    final password = ref.watch(passwordProvider);

    if (password.isEmpty) {
      return Expanded(
        flex: 1,
        child: Text(
          password.isEmpty ? 'Ingresa tu clave' : password.toString(),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      );
    }
    return const Expanded(
      flex: 1,
      child: HiddenPassword(),
    );
  }
}

class HiddenPassword extends ConsumerWidget {
  const HiddenPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final length = ref.watch(passwordProvider).length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var value = 0; value < length; value++)
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: Icon(
              Icons.circle_rounded,
              color: Color(0xFF544A6C),
            ),
          ),
        for (var value = 0; value < 6 - length; value++)
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: Icon(
              Icons.circle_outlined,
              color: Color(0xFF544A6C),
            ),
          ),
      ],
    );
  }
}

//TODO: can be sorted like the real app
class NumericPad extends ConsumerWidget {
  const NumericPad({super.key, required this.email})
      : numbers = const [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  final List<int> numbers;
  final String email;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        RowNumber(
          numbers: const [1, 2, 3],
          email: email,
        ),
        RowNumber(
          numbers: const [4, 5, 6],
          email: email,
        ),
        RowNumber(
          numbers: const [7, 8, 9],
          email: email,
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.fingerprint))),
              NumberButton(
                value: 0,
                email: email,
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    ref.read(passwordProvider.notifier).decrease();
                  },
                  icon: const Icon(
                    Icons.backspace,
                    color: Color(0xFF8F8B99),
                  ),
                ),
              )
            ],
          ),
        ),
        const Gap(20),
        const Text(
          'Olvidaste tu clave?',
          style: TextStyle(
            color: Color.fromARGB(255, 16, 203, 180),
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class RowNumber extends StatelessWidget {
  const RowNumber({
    super.key,
    required this.numbers,
    required this.email,
  });

  final List<int> numbers;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var number in numbers)
            NumberButton(
              value: number,
              email: email,
            )
        ],
      ),
    );
  }
}

class NumberButton extends ConsumerWidget {
  const NumberButton({
    super.key,
    required this.value,
    required this.email,
  });

  final int value;
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            ref.read(passwordProvider.notifier).increment(value, email);
          },
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.elliptical(4, 4),
              ),
            ),
            backgroundColor: const Color(0xFFEEEBF2),
          ),
          child: Text('$value'),
        ),
      ),
    );
  }
}
