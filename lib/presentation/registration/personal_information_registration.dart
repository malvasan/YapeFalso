import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';
import 'package:yapefalso/presentation/registration/user_registration_data_controller.dart';

enum _DocumentType { DNI }

@RoutePage()
class PersonalInformationRegistrationPage extends ConsumerStatefulWidget {
  const PersonalInformationRegistrationPage({super.key});

  @override
  ConsumerState<PersonalInformationRegistrationPage> createState() =>
      _PersonalInformationRegistrationPageState();
}

class _PersonalInformationRegistrationPageState
    extends ConsumerState<PersonalInformationRegistrationPage> {
  late TextEditingController emailController;
  late TextEditingController documentIDController;
  late TextEditingController nameController;
  String dropdownValue = _DocumentType.DNI.name;
  var _buttonEnabled = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    documentIDController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    documentIDController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Crear cuenta',
          style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        leading: IconButton(
          onPressed: () => ref.read(autorouteProvider).maybePop(),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
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
                    'Registra tus datos',
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Completa el formulario. Recuerda que todos los datos son obligatorios.',
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
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tipo de documento',
                ),
                value: dropdownValue,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                items: _DocumentType.values.map(
                  (e) {
                    return DropdownMenuItem(value: e.name, child: Text(e.name));
                  },
                ).toList(),
                onChanged: (value) {
                  // This is called when the user selects an item.
                  dropdownValue = value!;
                  setState(() {});
                },
              ),
            ),
            const Gap(35),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'N de documento',
                ),
                controller: documentIDController,
                maxLength: 8,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: const TextInputType.numberWithOptions(),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 8) {
                    return 'Ingrese correctamente su numero de documento';
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
            const Gap(15),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Correo electronico',
                ),
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !EmailValidator.validate(value)) {
                    return 'Ingrese correctamente su correo';
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
            const Gap(35),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre Completo',
                ),
                controller: nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese correctamente su nombre';
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
                      .updatePersonalInformation(
                        newName: nameController.text,
                        newEmail: emailController.text,
                        newDNI: int.parse(documentIDController.text),
                      );
                  ref
                      .read(autorouteProvider)
                      .push(const PasswordRegistrationRoute());
                }
              : null,
          style: FilledButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.elliptical(5, 5),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 16, 203, 180),
            foregroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: const Text(
            'Continuar',
            style: TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }
}
