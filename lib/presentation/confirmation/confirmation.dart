import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';

@RoutePage()
class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({required this.yapeo, super.key});

  final bool yapeo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () =>
              context.router.popUntilRouteWithName('PaymentsRoute'),
          icon: Icon(
            Icons.close,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Icon(
            Icons.check,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          const Gap(10),
          Container(
            margin: const EdgeInsets.all(45),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: [
                const Gap(20),
                Text(
                  '¡Yapeaste!',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Column(
                        children: [
                          Text(
                            'S/',
                            style: TextStyle(
                              color: Theme.of(context).disabledColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 25,
                            ),
                          ),
                          const Gap(20),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Text(
                        '2',
                        style: TextStyle(
                          fontSize: 55.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Made to',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  'date',
                  style: TextStyle(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                const Gap(15),
                const Divider(),
                const Gap(5),
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                      ),
                      children: const [
                        TextSpan(
                          text: 'N de celular: ',
                        ),
                        TextSpan(
                          text: '*** *** 717',
                          style: TextStyle(color: Colors.black),
                        )
                      ]),
                ),
                const Gap(5),
                const Divider(),
                const Gap(5),
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Destino: ',
                        ),
                        TextSpan(
                          text: 'Yape',
                          style: TextStyle(color: Colors.black),
                        )
                      ]),
                ),
                const Gap(5),
                const Divider(),
                const Gap(5),
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                      ),
                      children: const [
                        TextSpan(
                          text: 'N de operación: ',
                        ),
                        TextSpan(
                          text: '1231241',
                          style: TextStyle(color: Colors.black),
                        )
                      ]),
                ),
                const Gap(5),
                const Divider(),
                const Gap(50),
              ],
            ),
          ),
          const Gap(20),
          if (!yapeo) const FooterButtonsHistory(),
          if (yapeo) const FooterButtonsConfirnation(),
        ],
      ),
    );
  }
}

class FooterButtonsHistory extends StatelessWidget {
  const FooterButtonsHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            IconButton.filled(
              onPressed: () {},
              icon: const Icon(
                Icons.share_sharp,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: const Color.fromARGB(255, 122, 12, 147),
                side: const BorderSide(
                  color: Color.fromARGB(255, 122, 12, 147),
                ),
              ),
            ),
            Text(
              'Compartir',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 10,
              ),
            ),
          ],
        ),
        const Gap(20),
        Column(
          children: [
            IconButton.filled(
              onPressed: () => context.router.push(const PaymentRoute()),
              icon: const Icon(
                Icons.send,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: const Color.fromARGB(255, 16, 203, 180),
                side: const BorderSide(
                  color: Color.fromARGB(255, 16, 203, 180),
                ),
              ),
            ),
            Text(
              'Nuevo Yapeo',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FooterButtonsConfirnation extends StatelessWidget {
  const FooterButtonsConfirnation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            IconButton.filled(
              onPressed: () {},
              icon: const Icon(
                Icons.share_sharp,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: const Color.fromARGB(255, 122, 12, 147),
                side: const BorderSide(
                  color: Color.fromARGB(255, 122, 12, 147),
                ),
              ),
            ),
            Text(
              'Compartir',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 10,
              ),
            ),
          ],
        ),
        const Gap(20),
        Column(
          children: [
            IconButton.filled(
              onPressed: () =>
                  context.router.popUntilRouteWithName('PaymentsRoute'),
              icon: const Icon(
                Icons.house_outlined,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: const Color.fromARGB(255, 122, 12, 147),
                side: const BorderSide(
                  color: Color.fromARGB(255, 122, 12, 147),
                ),
              ),
            ),
            Text(
              'Ir a inicio',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 10,
              ),
            ),
          ],
        ),
        const Gap(20),
        Column(
          children: [
            IconButton.filled(
              onPressed: () {},
              icon: const Icon(
                Icons.adb_sharp,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: const Color.fromARGB(255, 16, 203, 180),
                side: const BorderSide(
                  color: Color.fromARGB(255, 16, 203, 180),
                ),
              ),
            ),
            Text(
              'Mis promos',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
