import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/domain/transfer.dart';
import 'package:yapefalso/presentation/payments_history/transfers_controller.dart';
import 'package:yapefalso/presentation/payments_history/user_controller.dart';
import 'package:yapefalso/presentation/payments_history/user_credit_controller.dart';
import 'package:yapefalso/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';

@RoutePage()
class PaymentsPage extends ConsumerStatefulWidget {
  const PaymentsPage({super.key});

  @override
  ConsumerState<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends ConsumerState<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(userProvider).isLoading;
    ref.listen(
      userProvider,
      (_, state) => state.whenData(
        (value) async {
          saveUser(
            number: value.phoneNumber,
            email: value.email,
          );
        },
      ),
    );

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
                      child: CustomCarousel(),
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
                          CupertinoActivityIndicator(
                            radius: 15,
                            color: Color(0xFF4A1972),
                          ),
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

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel>
    with TickerProviderStateMixin {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF4A1972),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CarouselSlider.builder(
            itemCount: 5,
            carouselController: _controller,
            itemBuilder: (context, index, realIndex) {
              return Card(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 4),
                color: Color(0xFFF0E0FD),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 5, 5, 5),
                          child: Card(
                            color: Colors.purple,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                              child: Text(
                                'Tienda',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(4, 2, 0, 0),
                          child: Text(
                            'Hasta 50% dcto',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(4, 0, 0, 6),
                          child: Text(
                            'en Tecnología aquí',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(15),
                    Icon(
                      Icons.phone_missed_rounded,
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              autoPlayInterval: Duration(seconds: 4),
              autoPlay: true,
              enlargeCenterPage: false,
              aspectRatio: 2.5,
              padEnds: false,
              viewportFraction: 0.75,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                  controller.forward(from: 0);
                  controller.repeat();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<int>.generate(5, (int index) => index * index,
                    growable: false)
                .asMap()
                .entries
                .map(
              (entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: _current == entry.key ? 30.0 : 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == entry.key
                            ? Colors.white
                            : Theme.of(context).primaryColor),
                    child: _current == entry.key
                        ? LinearProgressIndicator(
                            value: controller.value,
                            backgroundColor: Theme.of(context).primaryColor,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          )
                        : null,
                  ),
                );
              },
            ).toList(),
          ),
          Gap(4),
        ],
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
                      fontWeight: FontWeight.w600,
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

//TODO: carrusel package
//TODO: push notification

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
              ),
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
  bool showNext = true;
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(creditProvider).isLoading;

    if (isLoading) {
      showNext = !showNext;
    }

    if ((showNext == false) && (showBalance == true)) {
      showBalance = false;
      setState(() {});
    }

    if ((showNext == true) && (showBalance == false)) {
      showNext = false;
      setState(() {});
    }

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
                  if (!showBalance) {
                    showNext = !showNext;
                  }
                  setState(() {});
                },
          icon: showBalance && showNext
              ? const Icon(Icons.remove_red_eye_outlined)
              : const Icon(Icons.remove_red_eye),
          label: showBalance && showNext
              ? const Text('Ocultar saldo')
              : const Text('Mostrar saldo'),
        ),
        trailing: showBalance && showNext ? const BalanceField() : null,
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
              child: CupertinoActivityIndicator(
                radius: 15,
                color: Color(0xFF4A1972),
              ),
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
