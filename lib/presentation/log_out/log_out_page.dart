import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';

import 'package:yapefalso/presentation/log_out/sign_out_controller.dart';

@RoutePage()
class LogOutPage extends ConsumerWidget {
  const LogOutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(signOutProvider).isLoading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => ref.read(autorouteProvider).maybePop(),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        title: Text(
          'Menú',
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: 230,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                  child: Text(
                    'Full name',
                    maxLines: 1,
                    style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Card(
                          elevation: 7,
                          color: const Color(0xFF8C3D99),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Icon(
                              Icons.person_outline_rounded,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                        Text(
                          'Mi cuenta',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Card(
                          elevation: 7,
                          color: const Color(0xFF8C3D99),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Icon(
                              Icons.qr_code,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                        Text(
                          'Mi QR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Card(
                          elevation: 7,
                          color: const Color(0xFF8C3D99),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Icon(
                              Icons.settings_outlined,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                        Text(
                          'Ajustes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Card(
                          elevation: 7,
                          color: const Color(0xFF8C3D99),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Icon(
                              Icons.headphones_outlined,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                        Text(
                          'Ayuda',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(25),
                Card(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(17, 17, 17, 10),
                        child: Text(
                          'Novedades',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      const ListTile(
                        leading: Icon(Icons.bus_alert),
                        title: Text('Viajar en bus'),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      const ListTile(
                        leading: Icon(Icons.motorcycle),
                        title: Text('Delivery Tambo'),
                      ),
                    ],
                  ),
                ),
                const Gap(15),
                Card(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(17, 17, 17, 10),
                        child: Text(
                          'Yapeos',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      const ListTile(
                        leading: Icon(Icons.smartphone),
                        title: Text('Recargar Ceular'),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      const ListTile(
                        leading: Icon(Icons.water_drop_outlined),
                        title: Text('Yapear servicios'),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      const ListTile(
                        leading: Icon(Icons.monetization_on_outlined),
                        title: Text('Cambiar dólares'),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      const ListTile(
                        leading: Icon(Icons.lock_person_sharp),
                        title: Text('Código de aprobación'),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      const ListTile(
                        leading: Icon(Icons.link),
                        title: Text('Cobrar con YapeLink'),
                      ),
                    ],
                  ),
                ),
                const Gap(15),
                Card(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(17, 17, 17, 10),
                        child: Text(
                          'Compras',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      const ListTile(
                        leading: Icon(Icons.discount),
                        title: Text('Promos'),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      const ListTile(
                        leading: Icon(Icons.house_outlined),
                        title: Text('Tienda'),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      const ListTile(
                        leading: Icon(Icons.air_sharp),
                        title: Text('Entradas'),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      const ListTile(
                        leading: Icon(Icons.gamepad_outlined),
                        title: Text('Gaming'),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      const ListTile(
                        leading: Icon(Icons.gas_meter_outlined),
                        title: Text('Pedir Gas'),
                      ),
                    ],
                  ),
                ),
                const Gap(50),
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: Theme.of(context).unselectedWidgetColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      children: [
                        const TextSpan(text: 'Versión Yape: '),
                        TextSpan(
                          text: '1.0.0',
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
                          ),
                        )
                      ]),
                ),
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: Theme.of(context).unselectedWidgetColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      children: [
                        const TextSpan(text: 'Tipo de cuenta: '),
                        TextSpan(
                          text: 'Yape con BCP',
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
                          ),
                        )
                      ]),
                ),
                Text(
                  'Banco de Crédito del Perú'.toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: Theme.of(context).unselectedWidgetColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      children: [
                        const TextSpan(text: 'RUC: '),
                        TextSpan(
                          text: '02000174821',
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
                          ),
                        )
                      ]),
                ),
                const Gap(10),
                const Divider(
                  indent: 1,
                  endIndent: 1,
                ),
                const ListTile(
                  leading: Icon(
                    Icons.description_outlined,
                  ),
                  title: Text(
                    'Términos y condiciones',
                  ),
                ),
                const Divider(
                  indent: 1,
                  endIndent: 1,
                ),
                const ListTile(
                  leading: Icon(
                    Icons.lock_outline_rounded,
                  ),
                  title: Text(
                    'Política de privacidad',
                  ),
                ),
                const Divider(
                  indent: 1,
                  endIndent: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                  ),
                  title: const Text(
                    'Cerrar sesión',
                  ),
                  onTap: () => ref.read(signOutProvider.notifier).signOut(),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Material(
              color: Colors.black.withAlpha(150),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Gap(10),
                      CupertinoActivityIndicator(
                        radius: 15,
                        color: Color(0xFF4A1972),
                      ),
                      Gap(10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
