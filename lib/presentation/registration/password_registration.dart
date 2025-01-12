import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/presentation/registration/password_registration_controller.dart';
import 'package:yapefalso/utils.dart';

@RoutePage()
class PasswordRegistrationPage extends StatelessWidget {
  const PasswordRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              children: [
                const Gap(100),
                Icon(
                  Icons.lock_person_sharp,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 80,
                ),
                const Gap(30),
                Text(
                  'Crea tu clave Yape',
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 20,
                  ),
                ),
                const Gap(10),
                Text(
                  'Clave de 6 digitos',
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ],
            ),
          ),
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
    final password = ref.watch(passwordCreationProvider);

    if (password.isEmpty) {
      return Expanded(
        flex: 1,
        child: Text(
          password.isEmpty ? '' : password.toString(),
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
    final length = ref.watch(passwordCreationProvider).length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var value = 0; value < length; value++)
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: Icon(
              Icons.circle_rounded,
              color: contrastColor,
            ),
          ),
        for (var value = 0; value < 6 - length; value++)
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: Icon(
              Icons.circle_outlined,
              color: contrastColor,
            ),
          ),
      ],
    );
  }
}

class NumericPad extends ConsumerWidget {
  const NumericPad({
    super.key,
  }) : numbers = const [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  final List<int> numbers;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
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
                  onPressed: null,
                  icon: Icon(
                    Icons.fingerprint,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const NumberButton(
                value: 0,
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    ref.read(passwordCreationProvider.notifier).decrease();
                  },
                  icon: Icon(
                    Icons.backspace,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              )
            ],
          ),
        ),
        const Gap(10),
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
            ref.read(passwordCreationProvider.notifier).increment(value);
          },
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.elliptical(5, 5),
              ),
            ),
            backgroundColor: mainColorTransparent,
            foregroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Text('$value'),
        ),
      ),
    );
  }
}
