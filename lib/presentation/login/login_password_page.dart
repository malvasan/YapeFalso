import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';
import 'package:yapefalso/data/auth.dart';
import 'package:yapefalso/data/messaging.dart';
import 'package:yapefalso/presentation/appStartup/app_startup_controller.dart';
import 'package:yapefalso/presentation/login/login_password_controller.dart';
import 'package:yapefalso/presentation/login/sign_in_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:yapefalso/utils.dart';

@RoutePage()
class LoginPasswordPage extends ConsumerStatefulWidget {
  const LoginPasswordPage(
      {required this.email, required this.numbers, super.key});
  final String email;
  final List<int> numbers;
  @override
  ConsumerState<LoginPasswordPage> createState() => _LoginPasswordPageState();
}

class _LoginPasswordPageState extends ConsumerState<LoginPasswordPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messaging = ref.read(messagingProvider);
    final auth = ref.read(authenticationProvider);

    messaging.firebaseMessaging.onTokenRefresh.listen(
      (fcmToken) async {
        await auth.setFcmToken(fcmToken);
      },
    );

    final signInProviderState = ref.watch(signInProvider);
    final isLoading = signInProviderState.isLoading;
    final isError = signInProviderState is AsyncError<void>;
    final prefs = ref.watch(sharedPreferencesProvider).requireValue;

    var qr = prefs.getString('qr') ?? '';

    return Stack(children: [
      Scaffold(
        backgroundColor: mainColorDarker,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            onPressed: () => ref.read(autorouteProvider).maybePop(),
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
                      mainColorDarker,
                    ],
                  ),
                ),
                child: Center(
                  child: qr.isEmpty
                      ? Icon(
                          Icons.lock_person_sharp,
                          size: 80,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Card(child: QrImageView(data: qr)),
                        ),
                ),
              ),
            ),
            Flexible(
                flex: 2,
                child: PasswordSection(
                  email: widget.email,
                  numbers: widget.numbers,
                )),
          ],
        ),
      ),
      NotificationPopUp(
        isLoading: isLoading,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(10),
            CupertinoActivityIndicator(
              radius: 15,
              color: mainColorDarker,
            ),
            Gap(10),
            Text('Validando datos'),
          ],
        ),
      ),
      NotificationPopUp(
        isLoading: isError,
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
                ref.read(passwordProvider).clear();
                ref.invalidate(signInProvider);
              },
              child: const Text(
                'Intentar de nuevo',
                style: TextStyle(
                  fontSize: 17,
                  color: cupertinoColor,
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
                  color: cupertinoColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

class PasswordSection extends StatelessWidget {
  const PasswordSection(
      {required this.email, required this.numbers, super.key});
  final String email;
  final List<int> numbers;
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
            child: NumericPad(
              email: email,
              numbers: numbers,
            ),
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

class NumericPad extends ConsumerWidget {
  const NumericPad({super.key, required this.email, required this.numbers});

  final List<int> numbers;
  final String email;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        RowNumber(
          numbers: [numbers[0], numbers[1], numbers[2]],
          email: email,
        ),
        RowNumber(
          numbers: [numbers[3], numbers[4], numbers[5]],
          email: email,
        ),
        RowNumber(
          numbers: [numbers[6], numbers[7], numbers[8]],
          email: email,
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.fingerprint),
                ),
              ),
              NumberButton(
                value: numbers[9],
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
            color: contrastColor,
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
