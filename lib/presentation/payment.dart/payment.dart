import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';
import 'package:yapefalso/domain/transfer.dart';

import 'package:yapefalso/domain/user_metadata.dart';
import 'package:yapefalso/presentation/payment.dart/payment_controller.dart';
import 'package:yapefalso/presentation/payment.dart/user_transfer_controller.dart';

@RoutePage()
class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage({super.key, required this.phone});
  final int phone;

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  late TextEditingController _amountController;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      paymentProvider,
      (stateBefore, state) => state.whenData(
        (data) {
          if (data != null) {
            ref
                .read(autorouteProvider)
                .push(ConfirmationRoute(transferData: data, yapeo: true));
          }
        },
      ),
    );

    final paymentProviderState = ref.watch(paymentProvider);
    final isLoading = paymentProviderState.isLoading;
    final isError = paymentProviderState is AsyncError<Transfer?>;

    final userReceiver = ref.watch(userTransferProvider(phone: widget.phone));
    return userReceiver.when(
      data: (data) {
        return Stack(children: [
          PaymentBody(
            amountController: _amountController,
            textController: _textController,
            name: data.name,
            userReceiver: data,
            onPressed: () async {
              ref.read(paymentProvider.notifier).payment(
                  userNote: _textController.text,
                  amount: double.parse(_amountController.text),
                  receiverID: data.id);
            },
          ),
          Visibility(
            visible: isLoading,
            child: Material(
              color: Colors.black.withAlpha(150),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                      Text(
                        'Yapeando',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: isError,
            child: Material(
              color: Colors.black.withAlpha(150),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: CupertinoAlertDialog(
                    title: const Text('Te falta saldo para este yapeo'),
                    actions: [
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () {
                          ref.invalidate(paymentProvider);
                        },
                        child: const Text(
                          'Entendido',
                          style: TextStyle(color: Color(0xFF2073E8)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]);
      },
      error: (error, stackTrace) {
        return PaymentBody(
          amountController: _amountController,
          textController: _textController,
          name: widget.phone.toString(),
          onPressed: null,
        );
      },
      loading: () {
        return Stack(children: [
          PaymentBody(
            amountController: _amountController,
            textController: _textController,
            name: 'Buscando Yapero',
            onPressed: null,
          ),
          Visibility(
            visible: true,
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

class PaymentBody extends ConsumerWidget {
  const PaymentBody({
    super.key,
    required amountController,
    required textController,
    required this.name,
    this.onPressed,
    this.userReceiver,
  })  : _amountController = amountController,
        _textController = textController;

  final dynamic _amountController;
  final dynamic _textController;
  final UserMetadata? userReceiver;
  final String name;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            final stack = ref.read(autorouteProvider).stack;
            final path = stack[stack.length - 2].name;
            if (path != null) {
              if (path == 'CameraRoute') {
                ref.read(autorouteProvider).maybePop<bool>(false);
              }
            }
            ref.read(autorouteProvider).maybePop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text('Yapear a'),
        actions: [
          IconButton(
            onPressed: () => ref
                .read(autorouteProvider)
                .popUntilRouteWithName('PaymentsRoute'),
            icon: const Icon(
              Icons.close,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Gap(20),
                Text(
                  name,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Column(
                        children: [
                          Text('S/',
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                              )),
                          const Gap(20),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: TextField(
                        controller: _amountController,
                        cursorHeight: 45.0,
                        style: TextStyle(
                          fontSize: 55.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          hintText: '0',
                          border: InputBorder.none,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[\d\.]'),
                          ),
                          SinglePeriodEnforcer(),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).indicatorColor,
                    borderRadius: const BorderRadius.all(
                      Radius.elliptical(10, 12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Limite por yapeo S/ 500, limite total por dia S/ 2,000',
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _textController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Agregar Mensaje',
                      hintStyle: TextStyle(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: null,
                          label: const Text(
                            'Otros bancos',
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(5, 5)),
                            ),
                            foregroundColor:
                                const Color.fromARGB(255, 16, 203, 180),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 16, 203, 180),
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: FilledButton.tonalIcon(
                          onPressed: onPressed,
                          label: const Text('Yapear'),
                          style: FilledButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(5, 5)),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 16, 203, 180),
                              foregroundColor:
                                  Theme.of(context).scaffoldBackgroundColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SinglePeriodEnforcer extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    // Allow only one period
    if ('.'.allMatches(newText).length <= 1) {
      return newValue;
    }
    return oldValue;
  }
}
