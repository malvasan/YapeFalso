import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/domain/transfer.dart';
import 'package:yapefalso/presentation/payments_history/transfers_controller.dart';
import 'package:yapefalso/presentation/payments_history/user_credit_controller.dart';
import 'package:yapefalso/utils.dart';

@RoutePage()
class ConfirmationPage extends ConsumerWidget {
  const ConfirmationPage(
      {required this.yapeo, super.key, required this.transferData});

  final Transfer transferData;
  final bool yapeo;
  //TODO: screenshot when share
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A1972),
        leading: IconButton(
          onPressed: () {
            ref.invalidate(creditProvider);
            ref.invalidate(transfersProvider);
            return context.router.popUntilRouteWithName('PaymentsRoute');
          },
          icon: Icon(
            Icons.close,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.01, 0.2],
            colors: [
              const Color(0xFF4A1972),
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(10),
              Icon(
                Icons.check,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              const Gap(10),
              Container(
                margin: const EdgeInsets.all(45),
                child: CustomPaint(
                  painter: PathPainter(),
                  child: Column(
                    children: [
                      const Gap(20),
                      Text(
                        transferData.isPositive
                            ? '¡Te Yapearon!'
                            : '¡Yapeaste!',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 5,
                            child: Column(
                              children: [
                                Text(
                                  'S/',
                                  style: TextStyle(
                                    color: Theme.of(context).disabledColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 25,
                                  ),
                                ),
                                const Gap(20),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 6,
                            child: Text(
                              transferData.amount.toString(),
                              style: TextStyle(
                                fontSize: 55.0,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(20),
                      Text(
                        transferData.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        convertToYapeFormat(transferData.createdAt),
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Gap(20),
                      if (transferData.userNote != null)
                        if (transferData.userNote!.isNotEmpty) ...[
                          const Divider(),
                          const Gap(5),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: 15,
                                ),
                                children: [
                                  TextSpan(
                                    text: transferData.userNote,
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ]),
                          ),
                          const Gap(4),
                        ],
                      const Divider(),
                      const Gap(8),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(
                              color: Theme.of(context).disabledColor,
                              fontSize: 15,
                            ),
                            children: [
                              const TextSpan(
                                text: 'N de celular: ',
                              ),
                              TextSpan(
                                text: transferData.phoneNumber.toString(),
                                style: const TextStyle(color: Colors.black),
                              )
                            ]),
                      ),
                      const Gap(7),
                      const Divider(),
                      const Gap(7),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(
                              color: Theme.of(context).disabledColor,
                              fontSize: 15,
                            ),
                            children: const [
                              TextSpan(
                                text: 'Destino: ',
                              ),
                              TextSpan(
                                text: 'Yape',
                                style: TextStyle(color: Colors.black),
                              )
                            ]),
                      ),
                      const Gap(7),
                      const Divider(),
                      const Gap(7),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(
                              color: Theme.of(context).disabledColor,
                              fontSize: 15,
                            ),
                            children: [
                              const TextSpan(
                                text: 'N de operación: ',
                              ),
                              TextSpan(
                                text: transferData.id.toString(),
                                style: const TextStyle(color: Colors.black),
                              )
                            ]),
                      ),
                      const Gap(7),
                      const Divider(),
                      const Gap(50),
                    ],
                  ),
                ),
              ),
              if (!yapeo)
                FooterButtonsHistory(
                  phone: transferData.phoneNumber,
                ),
              if (yapeo) ...[
                const FooterButtonsConfirmation(),
                const Card(
                  margin: EdgeInsets.fromLTRB(45, 30, 45, 0),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Más en Yape',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Card(
                              color: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(5, 5)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Nuevo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Card(
                          color: Colors.yellow,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(7, 4, 7, 4),
                                          child: Text(
                                            'Yape Tienda',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(4, 2, 0, 0),
                                        child: Text(
                                          'Hasta 50% dcto',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(4, 0, 0, 6),
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
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: Card(
                                color: Colors.cyan,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Card(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    7, 4, 7, 4),
                                                child: Text(
                                                  'Pago de Servicios',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  4, 2, 0, 0),
                                              child: Text(
                                                'Paga tus recibos',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  4, 0, 0, 6),
                                              child: Text(
                                                'sin colas',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(15),
                                        Icon(
                                          Icons.phone_missed_rounded,
                                        ),
                                        Gap(15),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Card(
                                color: Colors.cyan,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Card(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    7, 4, 7, 4),
                                                child: Text(
                                                  'Dinero más\nseguro',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Gap(4),
                                    Icon(
                                      Icons.phone_missed_rounded,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class FooterButtonsHistory extends StatelessWidget {
  const FooterButtonsHistory({
    super.key,
    required this.phone,
  });

  final int phone;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            IconButton.filled(
              onPressed: () {},
              icon: const Icon(
                Icons.share_sharp,
                size: 32,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: const Color(0xFF8C3D99),
                side: const BorderSide(
                  color: Color(0xFF8C3D99),
                ),
              ),
            ),
            const Gap(5),
            Text(
              'Compartir',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        const Gap(20),
        Column(
          children: [
            IconButton.filled(
              onPressed: () => context.router.push(PaymentRoute(phone: phone)),
              icon: const Icon(
                Icons.send,
                size: 32,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: const Color.fromARGB(255, 16, 203, 180),
                side: const BorderSide(
                  color: Color.fromARGB(255, 16, 203, 180),
                ),
              ),
            ),
            const Gap(5),
            Text(
              'Nuevo Yapeo',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FooterButtonsConfirmation extends ConsumerWidget {
  const FooterButtonsConfirmation({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            IconButton.filled(
              onPressed: () {},
              icon: const Icon(
                Icons.share_sharp,
                size: 32,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: const Color(0xFF8C3D99),
                side: const BorderSide(
                  color: Color(0xFF8C3D99),
                ),
              ),
            ),
            Text(
              'Compartir',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        const Gap(20),
        Column(
          children: [
            IconButton.filled(
              onPressed: () {
                ref.invalidate(creditProvider);
                ref.invalidate(transfersProvider);
                context.router.popUntilRouteWithName('PaymentsRoute');
              },
              icon: const Icon(
                Icons.house_outlined,
                size: 32,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: const Color(0xFF8C3D99),
                side: const BorderSide(
                  color: Color(0xFF8C3D99),
                ),
              ),
            ),
            Text(
              'Ir a inicio',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        const Gap(20),
        Column(
          children: [
            IconButton.filled(
              onPressed: () {},
              icon: const Icon(
                Icons.adb_sharp,
                size: 32,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: const Color.fromARGB(255, 16, 203, 180),
                side: const BorderSide(
                  color: Color.fromARGB(255, 16, 203, 180),
                ),
              ),
            ),
            Text(
              'Mis promos',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      //..style = PaintingStyle.stroke
      ..color = Colors.white;

    final distance = size.width / 56;
    Path path = Path();
    const shapeHeight = 2.5;
    var pointBefore = const Point(0.0, shapeHeight);
    path.moveTo(pointBefore.x, pointBefore.y);

    for (var x = 1; x < 57; x++) {
      //path.moveTo(pointBefore.x, pointBefore.y);
      if (x % 2 == 1) {
        // path.quadraticBezierTo(pointBefore.x + (distance / 2), 0,
        //     pointBefore.x + distance, pointBefore.y);

        path.cubicTo(
            pointBefore.x + (distance * 3 / 7),
            pointBefore.y / 2,
            pointBefore.x + ((distance * 2) / 3),
            0,
            pointBefore.x + distance,
            0);
        pointBefore = Point(pointBefore.x + distance, 0);
      } else {
        // path.quadraticBezierTo(pointBefore.x + (distance / 2), 5,
        //     pointBefore.x + distance, pointBefore.y);

        path.cubicTo(
            pointBefore.x + ((distance * 1) / 3),
            pointBefore.y / 2,
            pointBefore.x + ((distance * 4) / 7),
            shapeHeight,
            pointBefore.x + distance,
            shapeHeight);
        pointBefore = Point(pointBefore.x + distance, shapeHeight);
      }
      //pointBefore = Point(pointBefore.x + distance, pointBefore.y);
    }

    //path.moveTo(0, pointBefore.y);
    //path.lineTo(size.width, shapeHeight);
    path.lineTo(size.width, size.height - shapeHeight);
    //path.lineTo(0, size.height - shapeHeight);

    pointBefore = Point(size.width, size.height - shapeHeight);
    path.moveTo(pointBefore.x, pointBefore.y);
    for (var x = 1; x < 57; x++) {
      //path.moveTo(pointBefore.x, pointBefore.y);

      if (x % 2 == 1) {
        // path.quadraticBezierTo(pointBefore.x - (distance / 2), size.height,
        //     pointBefore.x - distance, pointBefore.y);

        path.cubicTo(
            pointBefore.x - (distance * 3 / 7),
            pointBefore.y,
            pointBefore.x - ((distance * 1) / 2),
            size.height,
            pointBefore.x - distance,
            size.height);
        pointBefore = Point(pointBefore.x - distance, size.height);
      } else {
        // path.quadraticBezierTo(pointBefore.x - (distance / 2), size.height - 5,
        //     pointBefore.x - distance, pointBefore.y);

        path.cubicTo(
            pointBefore.x - (distance / 2),
            pointBefore.y,
            pointBefore.x - ((distance * 4) / 7),
            size.height - shapeHeight,
            pointBefore.x - distance,
            size.height - shapeHeight);
        pointBefore =
            Point(pointBefore.x - distance, size.height - shapeHeight);
      }

      //pointBefore = Point(pointBefore.x - distance, pointBefore.y);
    }
    //path.moveTo(pointBefore.x, pointBefore.y);
    path.lineTo(0, shapeHeight);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
