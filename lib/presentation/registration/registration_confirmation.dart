import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegistrationConfirmationPage extends StatelessWidget {
  const RegistrationConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Gap(100),
            Icon(
              Icons.cruelty_free_sharp,
              color: Theme.of(context).scaffoldBackgroundColor,
              size: 360,
            ),
            Text(
              '¡Te damos la bienvenida a Yape!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 30,
              ),
            ),
            Text(
              'Contigo crece cada vez más\n la comunidad yapera en todo el Perú',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 17,
              ),
            ),
            Expanded(child: Container()),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(5, 5),
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 16, 203, 180),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                minimumSize: const Size(371.4, 60),
              ),
              child: const Text(
                'Comenzar a Yapear',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const Gap(40),
          ],
        ),
      ),
    );
  }
}
