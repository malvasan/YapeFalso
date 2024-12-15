import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';
import 'package:yapefalso/presentation/registration/user_registration_data_controller.dart';

@RoutePage()
class PhoneRegistrationPage extends ConsumerStatefulWidget {
  const PhoneRegistrationPage({super.key});

  @override
  ConsumerState<PhoneRegistrationPage> createState() =>
      _PhoneRegistrationPageState();
}

class _PhoneRegistrationPageState extends ConsumerState<PhoneRegistrationPage> {
  late TextEditingController phone;
  var _buttonEnabled = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    phone = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    phone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.router.maybePop(),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        title: Text(
          'Crear cuenta',
          style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(25),
                  Text(
                    'Registro de Celular',
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Te enviaremos un código de verificación por SMS para validar tu número.',
                    maxLines: 2,
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(45),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Numero de celular',
                ),
                maxLength: 9,
                controller: phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: const TextInputType.numberWithOptions(),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 9) {
                    return 'Ingrese correctamente su número de celular';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (_formKey.currentState!.validate()) {
                    _buttonEnabled = true;
                    setState(() {});
                  } else {
                    _buttonEnabled = false;
                    setState(() {});
                  }
                },
              ),
            ),
            const Gap(45),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Al pulsar Continuar estoy aceptando los Terminos y condiciones de Yape.',
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FilledButton(
          onPressed: _buttonEnabled
              ? () {
                  ref
                      .read(userRegistrationDataProvider.notifier)
                      .updatePhoneNumber(int.parse(phone.text));

                  ref
                      .read(autorouteProvider)
                      .push(const PersonalInformationRegistrationRoute());
                }
              : null,
          style: FilledButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.elliptical(5, 5),
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 16, 203, 180),
              foregroundColor: Theme.of(context).scaffoldBackgroundColor),
          child: const Text(
            'Continuar',
            style: TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }
}
