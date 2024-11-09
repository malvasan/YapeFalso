import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';

@RoutePage()
class AccountTypeSelectionPage extends StatelessWidget {
  const AccountTypeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Crear cuenta',
          style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: 230,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Elige una opción para pagar y \ncobrar por Yape',
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                const Gap(50),
                Card(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      const Gap(20),
                      ListTile(
                        leading: const Icon(
                          Icons.abc_outlined,
                          size: 30,
                        ),
                        title: const Text('Con tu tarjeta de débito BCP'),
                        subtitle:
                            const Text('Cuenta corriente o ahorro en\nsoles.'),
                        subtitleTextStyle:
                            TextStyle(color: Theme.of(context).disabledColor),
                        onTap: () =>
                            context.router.push(const DebitCardRegistrtation()),
                      ),
                      const Gap(20),
                      ListTile(
                        leading: const Icon(
                          Icons.credit_card,
                          size: 20,
                        ),
                        title:
                            const Text('Con tu tarjeta de otro banco o caja'),
                        subtitle: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                color: Theme.of(context).unselectedWidgetColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              children: [
                                const TextSpan(text: 'Bancos: '),
                                TextSpan(
                                  text: 'Mi banco y Banco de la Nación.',
                                  style: TextStyle(
                                    color: Theme.of(context).disabledColor,
                                  ),
                                ),
                                const TextSpan(text: 'Cajas: '),
                                TextSpan(
                                  text:
                                      'Huancayo, Piura, Tacna, Trujillo y Sullana.',
                                  style: TextStyle(
                                    color: Theme.of(context).disabledColor,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      const Gap(20),
                      ListTile(
                        leading: const Icon(
                          Icons.person_add_alt,
                          size: 20,
                        ),
                        title: const Text(
                            'Si no tienes una cuenta bancaria \nusa solo tu DNI'),
                        subtitle: const Text(
                            'Tu dinero sera guardado en una\ncuenta de ahorros Yape..'),
                        subtitleTextStyle:
                            TextStyle(color: Theme.of(context).disabledColor),
                      ),
                      const Gap(20),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
