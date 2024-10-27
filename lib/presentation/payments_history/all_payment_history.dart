import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';

@RoutePage()
class AllPaymentHistoryPage extends StatelessWidget {
  const AllPaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () => context.router.back(),
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
            //TODO: add filter options
            onPressed: () {},
            icon: const Icon(
              Icons.tune,
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          const SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverCard(minExtent: 100, maxExtent: 100)),
          MultiSliver(
            pushPinnedChildren: true,
            children: [
              SliverPinnedHeader(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          alignment: Alignment.centerLeft,
                          child: Text('Month',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ))),
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
                  return const PaymentHistoryCard();
                }, childCount: 10),
              ),
            ],
          ),
          MultiSliver(
            pushPinnedChildren: true,
            children: [
              SliverPinnedHeader(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          alignment: Alignment.centerLeft,
                          child: Text('Month',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ))),
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
                  return const PaymentHistoryCard();
                }, childCount: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
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

class PaymentHistoryCard extends StatelessWidget {
  const PaymentHistoryCard({super.key});
  //TODO: use the data retrieved and use it
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Full name'),
          subtitle: const Text('Full date'),
          trailing: const Text('Payment'),
          onTap: () => context.router.push(
            ConfirmationRoute(yapeo: false),
          ),
        ),
        const Divider(
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }
}
