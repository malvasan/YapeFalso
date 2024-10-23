import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late var _amountController;
  late var _textController;

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        //TODO: obtain user name from database
        title: const Text('Yapear a'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.close),
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
                  'Full Name',
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
                          onPressed: () {},
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
                          onPressed: () {},
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
