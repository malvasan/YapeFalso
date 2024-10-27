import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/presentation/login/login_password_controller.dart';

@RoutePage()
class LoginPasswordPage extends StatelessWidget {
  const LoginPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: Center(child: Text('QR'))),
          PasswordSection(),
        ],
      ),
    );
  }
}

class PasswordSection extends StatelessWidget {
  const PasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
        child: const Column(
          children: [
            PasswordField(),
            Gap(10),
            Expanded(
              flex: 9,
              child: NumericPad(),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordField extends ConsumerWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: agregar el provider de google para que sea llamado al tener 6 caracteres
    // ref.listen(
    //   registrationControllerProvider,
    //   (_, state) => state.whenOrNull(
    //     error: (error, stackTrace) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text(error.toString())),
    //       );
    //     },
    //   ),
    // );
    final password = ref.watch(passwordProvider);

    //TODO add authentication with database
    if (password.length == 6) {
      log('call authentication');
      context.router.push(const PaymentsRoute());
    }
    if (password.isEmpty) {
      return Expanded(
        flex: 1,
        child: Text(
          password.isEmpty ? 'Ingresa tu clave' : password.toString(),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 17,
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
              color: Color.fromARGB(255, 16, 203, 180),
            ),
          ),
        for (var value = 0; value < 6 - length; value++)
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: Icon(
              Icons.circle_outlined,
              color: Color.fromARGB(255, 16, 203, 180),
            ),
          ),
      ],
    );
  }
}

//TODO: can be sorted like the real app
class NumericPad extends ConsumerWidget {
  const NumericPad({
    super.key,
  }) : numbers = const [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  final List<int> numbers;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        //TODO: refactor to be able to create the widgets without hardcode numberss
        //TODO: can be a grid
        const RowNumber(
          numbers: [1, 2, 3],
        ),
        const RowNumber(
          numbers: [4, 5, 6],
        ),
        const RowNumber(
          numbers: [7, 8, 9],
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.fingerprint))),
              const NumberButton(
                value: 0,
              ),
              Expanded(
                  child: IconButton(
                      onPressed: () {
                        ref.read(passwordProvider.notifier).decrease();
                      },
                      icon: const Icon(Icons.backspace)))
            ],
          ),
        ),
        const Gap(10),
        const Text(
          'Olvidaste tu clave?',
          style: TextStyle(
            color: Color.fromARGB(255, 16, 203, 180),
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}

class RowNumber extends StatelessWidget {
  const RowNumber({
    super.key,
    required this.numbers,
  });

  final List<int> numbers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var number in numbers)
            NumberButton(
              value: number,
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
  });

  final int value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () {
            ref.read(passwordProvider.notifier).increment(value);
          },
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.elliptical(5, 5),
              ),
            ),
            backgroundColor: const Color.fromARGB(144, 196, 21, 235),
          ),
          child: Text('$value'),
        ),
      ),
    );
  }
}
