import 'package:flutter/material.dart';

class AllPaymentHistoryPage extends StatelessWidget {
  const AllPaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        //TODO: obtain user name from database
        title: const Text('User name'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.headset_mic_outlined),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notification_add_outlined))
        ],
      ),
    );
  }
}
