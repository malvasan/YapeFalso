import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/domain/transfer.dart';
import 'package:yapefalso/utils.dart';

@RoutePage()
class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage(
      {required this.yapeo, super.key, required this.transferData});

  final Transfer transferData;
  final bool yapeo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A1972),
        leading: IconButton(
          onPressed: () =>
              context.router.popUntilRouteWithName('PaymentsRoute'),
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
        child: Column(
          children: [
            Icon(
              Icons.check,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            const Gap(10),
            Container(
              margin: const EdgeInsets.all(45),
              //color: Theme.of(context).scaffoldBackgroundColor,

              child: CustomPaint(
                painter: PathPainter(),
                child: Column(
                  children: [
                    const Gap(20),
                    Text(
                      transferData.isPositive ? '¡Te Yapearon!' : '¡Yapeaste!',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                    Text(
                      transferData.name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      convertToYapeFormat(transferData.createdAt),
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    const Gap(15),
                    if (transferData.userNote != null)
                      if (transferData.userNote!.isNotEmpty) ...[
                        const Divider(),
                        const Gap(5),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                              ),
                              children: [
                                TextSpan(
                                  text: transferData.userNote,
                                  style: const TextStyle(color: Colors.black),
                                )
                              ]),
                        ),
                      ],
                    const Divider(),
                    const Gap(5),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
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
                    const Gap(5),
                    const Divider(),
                    const Gap(5),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
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
                    const Gap(5),
                    const Divider(),
                    const Gap(5),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
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
                    const Gap(5),
                    const Divider(),
                    const Gap(50),
                  ],
                ),
              ),
            ),
            const Gap(20),
            if (!yapeo)
              FooterButtonsHistory(
                phone: transferData.phoneNumber,
              ),
            if (yapeo) const FooterButtonsConfirmation(),
          ],
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

class FooterButtonsConfirmation extends StatelessWidget {
  const FooterButtonsConfirmation({
    super.key,
  });

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
                  context.router.popUntilRouteWithName('PaymentsRoute'),
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
