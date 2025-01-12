import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';
import 'package:yapefalso/presentation/first_page/session_controller.dart';

@RoutePage()
class FirstPage extends ConsumerWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TODO: HERE 1 log out
    // ref.listen(
    //   authenticationStateProvider,
    //   (_, state) => state.whenData(
    //     (data) {
    //       final event = data.event;

    //       if (event == AuthChangeEvent.signedOut) {
    //         ref.read(autorouteProvider).replaceAll(
    //           [
    //             const FirstRoute(),
    //           ],
    //         );
    //       }
    //     },
    //   ),
    // );
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
                backgroundColor: const Color.fromARGB(255, 16, 203, 180),
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
                backgroundColor: const Color(0xFF8C3D99),
                side: const BorderSide(
                  color: Color(0xFF8C3D99),
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
