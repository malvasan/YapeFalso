import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/data/auth.dart';
import 'package:yapefalso/data/messaging.dart';

import 'package:yapefalso/presentation/registration/sign_up_controller.dart';
import 'package:yapefalso/presentation/registration/user_registration_data_controller.dart';
import 'package:yapefalso/utils.dart';

List<String> _months = [
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
];

List<String> _years = [
  '24',
  '25',
  '26',
  '27',
];

@RoutePage()
class DebitCardRegistrtation extends ConsumerStatefulWidget {
  const DebitCardRegistrtation({super.key});

  @override
  ConsumerState<DebitCardRegistrtation> createState() =>
      _DebitCardRegistrtationState();
}

class _DebitCardRegistrtationState
    extends ConsumerState<DebitCardRegistrtation> {
  late TextEditingController cardID;
  String dropdownMonth = _months[0];
  String dropdownYear = _years[0];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cardID = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    cardID.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messaging = ref.read(messagingProvider);
    final auth = ref.read(authenticationProvider);
    final isLoading = ref.watch(signUpProvider).isLoading;

    messaging.firebaseMessaging.onTokenRefresh.listen(
      (fcmToken) async {
        await auth.setFcmToken(fcmToken);
      },
    );

    return Stack(children: [
      Form(
        key: _formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title: Text(
              'Crear cuenta',
              style:
                  TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
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
                      'Registra tu tarjeta BCP',
                      maxLines: 2,
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Conecta tu cuenta de ahorros o corriente en soles\n para hacer transferencias en Yape.',
                      maxLines: 2,
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(50),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.abc_outlined,
                              size: 40,
                            ),
                            const Text('Número de tarjeta'),
                            TextFormField(
                              controller: cardID,
                              maxLength: 16,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: false,
                                signed: false,
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 16) {
                                  return 'Ingrese correctamente su número de tarjeta';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (_formKey.currentState!.validate()) {
                                  ref
                                      .read(
                                          userRegistrationDataProvider.notifier)
                                      .updateAccountNumber(cardID.text);
                                  signUp(ref);
                                  setState(() {});
                                }
                              },
                            ),
                            const Gap(20),
                            Row(
                              children: [
                                const Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Vencimiento',
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                const Gap(10),
                                Flexible(
                                  flex: 1,
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      border: null,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    value: null,
                                    items: _months.map(
                                      (e) {
                                        return DropdownMenuItem(
                                            value: e, child: Text(e));
                                      },
                                    ).toList(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Seleccione';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      dropdownMonth = value!;
                                      if (_formKey.currentState!.validate()) {
                                        ref
                                            .read(userRegistrationDataProvider
                                                .notifier)
                                            .updateAccountNumber(cardID.text);
                                        signUp(ref);
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                                const Gap(10),
                                Flexible(
                                  flex: 1,
                                  child: DropdownButtonFormField(
                                    value: null,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    items: _years.map(
                                      (e) {
                                        return DropdownMenuItem(
                                            value: e, child: Text(e));
                                      },
                                    ).toList(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Seleccione';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      dropdownYear = value!;
                                      if (_formKey.currentState!.validate()) {
                                        ref
                                            .read(userRegistrationDataProvider
                                                .notifier)
                                            .updateAccountNumber(cardID.text);
                                        signUp(ref);
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
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
    ]);
  }

  void signUp(WidgetRef ref) {
    ref.read(signUpProvider.notifier).signUp();
  }
}
