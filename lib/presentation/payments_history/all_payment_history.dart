import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';
import 'package:yapefalso/domain/transfer.dart';
import 'package:yapefalso/presentation/payments_history/all_transfers_controller.dart';
import 'package:yapefalso/presentation/payments_history/widgets/payment_card.dart';
import 'package:yapefalso/utils.dart';

@RoutePage()
class AllPaymentHistoryPage extends ConsumerStatefulWidget {
  const AllPaymentHistoryPage({super.key});

  @override
  ConsumerState<AllPaymentHistoryPage> createState() =>
      _AllPaymentHistoryPageState();
}

class _AllPaymentHistoryPageState extends ConsumerState<AllPaymentHistoryPage> {
  var days = 90;
  @override
  Widget build(BuildContext context) {
    final dateNow = DateTime.now();
    final dateToday = DateTime(dateNow.year, dateNow.month, dateNow.day);
    final dateFilter = dateToday.subtract(Duration(days: days));

    return ref.watch(TransfersFilteredProvider(date: dateFilter)).when(
      data: (data) {
        final separatedTransfers = separateTransfers(data);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              onPressed: () => ref.read(autorouteProvider).maybePop(),
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            title: const Text('Movimientos'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.email_outlined,
                ),
              ),
              CupertinoButton(
                child: Icon(
                  Icons.tune,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return CupertinoActionSheet(
                        message: Text(
                          'Selecciona un filtro',
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              days = 0;
                              setState(() {});
                              ref.read(autorouteProvider).maybePop();
                            },
                            child: const Text(
                              'Solo hoy',
                              style: TextStyle(
                                fontSize: 20,
                                color: cupertinoColor,
                              ),
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              days = 7;
                              setState(() {});
                              ref.read(autorouteProvider).maybePop();
                            },
                            child: const Text(
                              'Últimos 7 días',
                              style: TextStyle(
                                fontSize: 20,
                                color: cupertinoColor,
                              ),
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              days = 15;
                              setState(() {});
                              ref.read(autorouteProvider).maybePop();
                            },
                            child: const Text(
                              'Últimos 15 días',
                              style: TextStyle(
                                fontSize: 20,
                                color: cupertinoColor,
                              ),
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              days = 30;
                              setState(() {});
                              ref.read(autorouteProvider).maybePop();
                            },
                            child: const Text(
                              'Últimos 30 días',
                              style: TextStyle(
                                fontSize: 20,
                                color: cupertinoColor,
                              ),
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              days = 90;
                              setState(() {});
                              ref.read(autorouteProvider).maybePop();
                            },
                            child: const Text(
                              'Últimos 90 días',
                              style: TextStyle(
                                fontSize: 20,
                                color: cupertinoColor,
                              ),
                            ),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () =>
                              ref.read(autorouteProvider).maybePop(),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                                fontSize: 20,
                                color: cupertinoColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              const SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomSliverCard(minExtent: 100, maxExtent: 100)),
              ...separatedTransfers.map(
                (e) {
                  return MultiSliver(
                    pushPinnedChildren: true,
                    children: [
                      SliverPinnedHeader(
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  Months.values[e[0].createdAt.month - 1].name,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const Divider(
                                indent: 10,
                                endIndent: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return PaymentHistoryCard(
                            transfer: e[index],
                          );
                        }, childCount: e.length),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              onPressed: () => ref.read(autorouteProvider).maybePop(),
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            title: const Text('Movimientos'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.email_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.tune,
                ),
              )
            ],
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return PaymentHistoryCard(
                transfer: Transfer(
                    id: 0,
                    amount: 0,
                    userNote: '',
                    name: '',
                    phoneNumber: 0,
                    createdAt: DateTime.now(),
                    isPositive: false),
              );
            },
            itemCount: 3,
          ),
        );
      },
      loading: () {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              onPressed: () => ref.read(autorouteProvider).maybePop(),
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            title: const Text('Movimientos'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.email_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.tune,
                ),
              )
            ],
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return PaymentHistoryCard(
                transfer: Transfer(
                    id: 0,
                    amount: 0,
                    userNote: '',
                    name: '',
                    phoneNumber: 0,
                    createdAt: DateTime.now(),
                    isPositive: false),
              );
            },
            itemCount: 3,
          ),
        );
      },
    );
  }
}

class Section extends MultiSliver {
  Section({
    super.key,
    required String title,
    required Color containerColor,
    required Color titleColor,
    required List<Widget> items,
  }) : super(
          pushPinnedChildren: true,
          children: [
            SliverPinnedHeader(
              child: Container(
                color: containerColor,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: titleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(items),
            ),
          ],
        );
}

class CustomSliverCard extends SliverPersistentHeaderDelegate {
  const CustomSliverCard({
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
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          const Gap(10),
          Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 5,
            child: const ListTile(
              title: Text('Propaganda'),
              subtitle: Text('*sujeto a evaluacion crediticia'),
            ),
          ),
          const Gap(10),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
