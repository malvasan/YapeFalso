import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
      body: CustomScrollView(
        slivers: [
          const SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverGrid(minExtent: 200, maxExtent: 200)),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Card(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const ListTile(
                    leading: Icon(Icons.access_alarm_rounded),
                    title: Text('Main information'),
                    subtitle: Text('Extra information'),
                  ),
                ),
                const Gap(10),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: PaymentListHeader(),
          ),
          DecoratedSliver(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return const PaymentHistoryCard();
              }, childCount: 10),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const PaymentListFooter(),
    );
  }
}

class CustomSliverGrid extends SliverPersistentHeaderDelegate {
  const CustomSliverGrid({
    required this.minExtent,
    required this.maxExtent,
  });
  @override
  final double minExtent;
  @override
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: GridView.count(
        crossAxisCount: 4,
        children: [
          ...List.generate(
            8,
            (index) {
              return const ExtraService();
            },
          )
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class PaymentListHeader extends StatelessWidget {
  const PaymentListHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Gap(10),
          const Balance(),
          IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    'Movimientos',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  )),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.refresh),
                    color: const Color.fromARGB(255, 16, 203, 180),
                  ),
                  const VerticalDivider(
                    endIndent: 10,
                    indent: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 16, 203, 180)),
                    child: const Text('Ver todos'),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
          ),
        ],
      ),
    );
  }
}

class PaymentListFooter extends StatelessWidget {
  const PaymentListFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.qr_code),
              label: const Text('Escanear QR'),
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                foregroundColor: const Color.fromARGB(255, 16, 203, 180),
                side: const BorderSide(
                  color: Color.fromARGB(255, 16, 203, 180),
                ),
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: FilledButton.tonalIcon(
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text('Yapear'),
              style: FilledButton.styleFrom(
                  shape: const RoundedRectangleBorder(),
                  backgroundColor: const Color.fromARGB(255, 16, 203, 180),
                  foregroundColor: Theme.of(context).scaffoldBackgroundColor),
            ),
          )
        ],
      ),
    );
  }
}

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  //TODO: retrieve the balance from database

  bool showBalance = false;
  @override
  Widget build(BuildContext context) {
    final balance = 0;

    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 5,
      child: ListTile(
        iconColor: Theme.of(context).primaryColor,
        textColor: Theme.of(context).primaryColor,

        leading: TextButton.icon(
          onPressed: () {
            showBalance = !showBalance;
            setState(() {});
          },
          icon: showBalance
              ? const Icon(Icons.remove_red_eye_outlined)
              : const Icon(Icons.remove_red_eye),
          label: showBalance
              ? const Text('Ocultar saldo')
              : const Text('Mostrar saldo'),
        ),
        //TODO: change with widget BalanceField
        trailing: showBalance ? const Text('S/. 45') : null,
      ),
    );
  }
}

//TODO: retrieve data in real time
// class BalanceField extends ConsumerWidget {
//   const BalanceField({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ref.watch(firebaseImageProvider).when(
//         loading: () => const CircularProgressIndicator(),
//         error: (error, stackTrace) {},
//         data: (balance) {
//           return Text('S/. $balance');
//         });
//   }
// }

class PaymentHistoryCard extends StatelessWidget {
  const PaymentHistoryCard({super.key});
  //TODO: use the data retrieved and use it
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ListTile(
          title: Text('Full name'),
          subtitle: Text('Full date'),
          trailing: Text('Payment'),
        ),
        Divider(
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }
}

class ExtraService extends StatelessWidget {
  const ExtraService({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: const Center(
                child: Icon(Icons.accessibility_new_rounded),
              ),
            ),
          ),
        ),
        Text('Prueba',
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            )),
        const Gap(10),
      ],
    );
  }
}
