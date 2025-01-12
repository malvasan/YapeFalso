import 'dart:io';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';
import 'package:yapefalso/domain/transfer.dart';
import 'package:yapefalso/presentation/payments_history/transfers_controller.dart';
import 'package:yapefalso/presentation/payments_history/user_credit_controller.dart';
import 'package:yapefalso/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

@RoutePage()
class ConfirmationPage extends ConsumerStatefulWidget {
  const ConfirmationPage(
      {required this.yapeo, super.key, required this.transferData});
  final Transfer transferData;
  final bool yapeo;
  @override
  ConsumerState<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends ConsumerState<ConfirmationPage> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: mainColorDarker,
        leading: IconButton(
          onPressed: () {
            ref.invalidate(creditProvider);
            ref.invalidate(transfersProvider);
            return ref
                .read(autorouteProvider)
                .popUntilRouteWithName('PaymentsRoute');
          },
          icon: Icon(
            Icons.close,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.01, 0.2],
                    colors: [
                      mainColorDarker,
                      Theme.of(context).primaryColor,
                    ],
                  ),
                ),
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
                              widget.transferData.isPositive
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
                                          color:
                                              Theme.of(context).disabledColor,
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
                                    widget.transferData.amount.toString(),
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
                              widget.transferData.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              convertToYapeFormat(
                                  widget.transferData.createdAt),
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const Gap(20),
                            if (widget.transferData.userNote != null)
                              if (widget.transferData.userNote!.isNotEmpty) ...[
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
                                          text: widget.transferData.userNote,
                                          style: const TextStyle(
                                              color: Colors.black),
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
                                      text: widget.transferData.phoneNumber
                                          .toString(),
                                      style:
                                          const TextStyle(color: Colors.black),
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
                                      text: widget.transferData.id.toString(),
                                      style:
                                          const TextStyle(color: Colors.black),
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
                  ],
                ),
              ),
            ),
            if (!widget.yapeo)
              FooterButtonsHistory(
                phone: widget.transferData.phoneNumber,
                screenshotController: screenshotController,
              ),
            if (widget.yapeo) ...[
              FooterButtonsConfirmation(
                screenshotController: screenshotController,
              ),
              const AdvertisingApp(),
            ]
          ],
        ),
      ),
    );
  }
}

class FooterButtonsHistory extends ConsumerWidget {
  const FooterButtonsHistory({
    super.key,
    required this.phone,
    required this.screenshotController,
  });

  final int phone;
  final ScreenshotController screenshotController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            IconButton.filled(
              onPressed: () async {
                await screenshotController
                    .capture(delay: const Duration(milliseconds: 10))
                    .then((image) async {
                  if (image != null) {
                    final directory = await getApplicationDocumentsDirectory();
                    final imagePath =
                        await File('${directory.path}/image.png').create();
                    await imagePath.writeAsBytes(image);

                    await Share.shareXFiles([XFile(imagePath.path)]);
                  }
                });
              },
              icon: const Icon(
                Icons.share_sharp,
                size: 32,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: mainColorTransparent,
                side: const BorderSide(
                  color: mainColorTransparent,
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
              onPressed: () =>
                  ref.read(autorouteProvider).push(PaymentRoute(phone: phone)),
              icon: const Icon(
                Icons.send,
                size: 32,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: contrastColor,
                side: const BorderSide(
                  color: contrastColor,
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
    required this.screenshotController,
  });
  final ScreenshotController screenshotController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            IconButton.filled(
              onPressed: () async {
                await screenshotController
                    .capture(delay: const Duration(milliseconds: 10))
                    .then((image) async {
                  if (image != null) {
                    final directory = await getApplicationDocumentsDirectory();
                    final imagePath =
                        await File('${directory.path}/image.png').create();
                    await imagePath.writeAsBytes(image);

                    await Share.shareXFiles([XFile(imagePath.path)]);
                  }
                });
              },
              icon: const Icon(
                Icons.share_sharp,
                size: 32,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: mainColorTransparent,
                side: const BorderSide(
                  color: mainColorTransparent,
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
                ref
                    .read(autorouteProvider)
                    .popUntilRouteWithName('PaymentsRoute');
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
                backgroundColor: mainColorTransparent,
                side: const BorderSide(
                  color: mainColorTransparent,
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
                backgroundColor: contrastColor,
                side: const BorderSide(
                  color: contrastColor,
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
    Paint paint = Paint()..color = Colors.white;

    final distance = size.width / 56;
    Path path = Path();
    const shapeHeight = 2.5;
    var pointBefore = const Point(0.0, shapeHeight);
    path.moveTo(pointBefore.x, pointBefore.y);

    for (var x = 1; x < 57; x++) {
      if (x % 2 == 1) {
        path.cubicTo(
            pointBefore.x + (distance * 3 / 7),
            pointBefore.y / 2,
            pointBefore.x + ((distance * 2) / 3),
            0,
            pointBefore.x + distance,
            0);
        pointBefore = Point(pointBefore.x + distance, 0);
      } else {
        path.cubicTo(
            pointBefore.x + ((distance * 1) / 3),
            pointBefore.y / 2,
            pointBefore.x + ((distance * 4) / 7),
            shapeHeight,
            pointBefore.x + distance,
            shapeHeight);
        pointBefore = Point(pointBefore.x + distance, shapeHeight);
      }
    }

    path.lineTo(size.width, size.height - shapeHeight);

    pointBefore = Point(size.width, size.height - shapeHeight);
    path.moveTo(pointBefore.x, pointBefore.y);
    for (var x = 1; x < 57; x++) {
      if (x % 2 == 1) {
        path.cubicTo(
            pointBefore.x - (distance * 3 / 7),
            pointBefore.y,
            pointBefore.x - ((distance * 1) / 2),
            size.height,
            pointBefore.x - distance,
            size.height);
        pointBefore = Point(pointBefore.x - distance, size.height);
      } else {
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
    }

    path.lineTo(0, shapeHeight);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AdvertisingApp extends StatelessWidget {
  const AdvertisingApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
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
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Card(
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
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
                                  padding: EdgeInsets.fromLTRB(4, 2, 0, 0),
                                  child: Text(
                                    'Paga tus recibos',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(4, 0, 0, 6),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
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
    );
  }
}
