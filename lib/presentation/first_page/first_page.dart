import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';
import 'package:yapefalso/utils.dart';

@RoutePage()
class FirstPage extends ConsumerWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            const Gap(150),
            Icon(
              Icons.smartphone,
              color: Theme.of(context).scaffoldBackgroundColor,
              size: 180,
            ),
            const Gap(30),
            Text(
              'Envia y recibe dinero',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                'Transfiere gratis a toda la comunidad yapera desde tu celular',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(child: Container()),
            FilledButton.tonalIcon(
              onPressed: () => ref
                  .read(autorouteProvider)
                  .push(const PhoneRegistrationRoute()),
              label: Text('Crear Cuenta'.toUpperCase()),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                backgroundColor: contrastColor,
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                minimumSize: const Size(371.4, 50),
              ),
            ),
            const Gap(20),
            OutlinedButton.icon(
              onPressed: () =>
                  ref.read(autorouteProvider).push(const LoginEmailRoute()),
              label: Text('Ya tengo una cuenta'.toUpperCase()),
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: mainColorTransparent,
                side: const BorderSide(
                  color: mainColorTransparent,
                ),
                minimumSize: const Size(371.4, 50),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
