import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/domain/transfer.dart';
import 'package:yapefalso/presentation/payments_history/transfers_controller.dart';
import 'package:yapefalso/presentation/payments_history/user_controller.dart';
import 'package:yapefalso/presentation/payments_history/user_credit_controller.dart';
import 'package:yapefalso/utils.dart';

@RoutePage()
class PaymentsPage extends ConsumerWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(userProvider).isLoading;

    return ref.watch(userProvider).when(
          skipLoadingOnRefresh: false,
          data: (data) {
            return Scaffold(
              backgroundColor: const Color(0xFF4A1972),
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                leading: IconButton(
                  onPressed: () => context.router.push(const LogOutRoute()),
                  icon: const Icon(
                    Icons.menu,
                  ),
                ),
                title: Text(data.name),
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
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.15, 1.0],
                    colors: [
                      Theme.of(context).primaryColor,
                      const Color(0xFF4A1972),
                    ],
                  ),
                ),
                child: CustomScrollView(
                  slivers: [
                    const SliverPersistentHeader(
                      pinned: true,
                      delegate:
                          CustomSliverGrid(minExtent: 210, maxExtent: 210),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: const Color(0xFF4A1972),
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
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: const Color(0xFF4A1972),
                        child: const PaymentListHeader(),
                      ),
                    ),
                    const TransfersHistory(),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: const PaymentListFooter(),
            );
          },
          error: (error, stackTrace) => Center(
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () => ref.invalidate(userProvider),
                    child: Text(error.toString()))
              ],
            ),
          ),
          loading: () {
            return Stack(children: [
              Scaffold(
                  backgroundColor: const Color(0xFF4A1972),
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                    leading: IconButton(
                      onPressed: () => context.router.push(const LogOutRoute()),
                      icon: const Icon(
                        Icons.menu,
                      ),
                    ),
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
                  body: Column(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.25, 1.0],
                              colors: [
                                Theme.of(context).primaryColor,
                                const Color(0xFF4A1972),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 6,
                        child: Container(
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
                        ),
                      )
                    ],
                  )),
              Visibility(
                visible: isLoading,
                child: Material(
                  color: Colors.black.withAlpha(150),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Gap(10),
                          CircularProgressIndicator(),
                          Gap(10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]);
          },
        );
  }
}

class TransfersHistory extends ConsumerWidget {
  const TransfersHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(transfersProvider).when(
          skipLoadingOnRefresh: false,
          data: (data) {
            return DecoratedSliver(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              // sliver: SliverList(
              //   delegate: SliverChildBuilderDelegate((context, index) {
              //     return const PaymentHistoryCard();
              //   }, childCount: 10),
              // ),
              sliver: SliverList.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return PaymentHistoryCard(transfer: data[index]);
                },
              ),
            );
          },
          error: (error, stackTrace) => SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          loading: () => SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.25, 1.0],
          colors: [
            Theme.of(context).primaryColor,
            const Color(0xFF4A1972),
          ],
        ),
      ),
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

class PaymentListHeader extends ConsumerWidget {
  const PaymentListHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    onPressed: () {
                      ref.invalidate(transfersProvider);
                    },
                    icon: const Icon(Icons.refresh),
                    color: const Color.fromARGB(255, 16, 203, 180),
                  ),
                  const VerticalDivider(
                    endIndent: 10,
                    indent: 10,
                  ),
                  TextButton(
                    onPressed: () =>
                        context.router.push(const AllPaymentHistoryRoute()),
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
              onPressed: () => context.router.push(const CameraRoute()),
              icon: const Icon(
                Icons.qr_code,
              ),
              label: const Text('Escanear QR'),
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(5, 5),
                  ),
                ),
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
              onPressed: () => context.router.push(const ContactSearchRoute()),
              icon: const Icon(
                Icons.send,
              ),
              label: const Text('Yapear'),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(5, 5),
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 16, 203, 180),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Balance extends ConsumerStatefulWidget {
  const Balance({super.key});

  @override
  ConsumerState<Balance> createState() => _BalanceState();
}

class _BalanceState extends ConsumerState<Balance> {
  bool showBalance = false;
  @override
  Widget build(BuildContext context) {
    //final balance = 0;
    final isLoading = ref.watch(creditProvider).isLoading;
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 7,
      child: ListTile(
        iconColor: Theme.of(context).primaryColor,
        textColor: Theme.of(context).primaryColor,
        leading: TextButton.icon(
          onPressed: isLoading
              ? null
              : () {
                  showBalance = !showBalance;
                  if (showBalance) {
                    ref.invalidate(creditProvider);
                  }
                  setState(() {});
                },
          icon: showBalance
              ? const Icon(Icons.remove_red_eye_outlined)
              : const Icon(Icons.remove_red_eye),
          label: showBalance
              ? const Text('Ocultar saldo')
              : const Text('Mostrar saldo'),
        ),
        trailing: showBalance ? const BalanceField() : null,
      ),
    );
  }
}

class BalanceField extends ConsumerWidget {
  const BalanceField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(creditProvider).when(
        skipLoadingOnRefresh: false,
        loading: () => const Padding(
              padding: EdgeInsets.all(1.0),
              child: CircularProgressIndicator(),
            ),
        error: (error, stackTrace) => Text('$error'),
        data: (balance) {
          return Text(
            'S/ $balance',
            style: const TextStyle(color: Colors.black, fontSize: 16),
          );
        });
  }
}

class PaymentHistoryCard extends StatelessWidget {
  const PaymentHistoryCard({super.key, required this.transfer});

  final Transfer transfer;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            transfer.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            convertToYapeFormat(transfer.createdAt),
            style: TextStyle(color: Theme.of(context).disabledColor),
          ),
          trailing: transfer.isPositive
              ? Text(
                  'S/ ${transfer.amount.toStringAsPrecision(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              : Text(
                  '- S/ ${transfer.amount.toStringAsPrecision(2)}',
                  style: const TextStyle(
                    color: Color(0xFFD3526E),
                    fontSize: 18,
                  ),
                ),
          onTap: () => context.router.push(
            ConfirmationRoute(
              yapeo: false,
              transferData: transfer,
            ),
          ),
        ),
        const Divider(
          indent: 10,
          endIndent: 10,
          height: 1,
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
