import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({super.key});

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  late TextEditingController email;
  var _buttonEnabled = false;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    email = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.smartphone,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 100,
                    ),
                  ],
                ),
              ),
            ),
            Container(
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
                  const Gap(20),
                  Text(
                    'Ingresa a tu Yape',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(text: '¿Todavía no te registraste? '),
                          TextSpan(
                            text: 'Crea tu Yape aqui',
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: const TextStyle(
                              color: Color.fromARGB(255, 16, 203, 180),
                            ),
                          )
                        ]),
                  ),
                  const Gap(45),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Correo Electrónico',
                      ),
                      controller: email,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Ingresa un correo electrónico válido';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          _buttonEnabled = false;
                          setState(() {});
                        } else {
                          _buttonEnabled = true;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  const Gap(45),
                  FilledButton.tonalIcon(
                    onPressed: _buttonEnabled
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Processing Data'),
                              ),
                            );
                          }
                        : null,
                    label: Text('Continuar'.toUpperCase()),
                    style: FilledButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                      ),
                      backgroundColor: const Color.fromARGB(255, 16, 203, 180),
                      foregroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      minimumSize: const Size(371.4, 50),
                    ),
                  ),
                  const Gap(45),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  const Gap(45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Card(
                            elevation: 7,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.lock_outline,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const Text(
                            'Olvide mi\nclave o correo',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      const Gap(30),
                      Column(
                        children: [
                          Card(
                            elevation: 7,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.change_circle,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const Text(
                            'Cambie mi\n numero',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          )
                        ],
                      )
                    ],
                  ),
                  const Gap(45),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(text: '¿Dudas? '),
                          TextSpan(
                            text: 'Ingresa al Centro de Ayuda',
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: const TextStyle(
                                color: Color.fromARGB(255, 16, 203, 180),
                                fontWeight: FontWeight.w700),
                          )
                        ]),
                  ),
                  const Gap(70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
