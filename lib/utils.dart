import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:yapefalso/domain/transfer.dart';
import 'package:yapefalso/presentation/appStartup/app_startup_controller.dart';

enum Months { en, feb, mar, abr, may, jun, jul, ag, set, oct, nov, dic }

const monthsFullName = [
  'Enero',
  'Febrero',
  'Marzo',
  'Abril',
  'Mayo',
  'Junio',
  'Julio',
  'Agosto',
  'Septiembre',
  'Octubre',
  'Noviembre',
  'Diciembre'
];

const mainColor = Color(0xFF742284);
const mainColorTransparent = Color(0xFF8C3D99);
const mainColorDarker = Color(0xFF4A1972);
const contrastColor = Color.fromARGB(255, 16, 203, 180);
const cupertinoColor = Color(0xFF2073E8);

String convertToYapeFormat(DateTime date) {
  final localDate = date.toLocal();
  final month = Months.values[localDate.month - 1].name;
  if (localDate.hour < 12) {
    return '${localDate.day} $month ${localDate.year} - ${localDate.hour}:${localDate.minute} am';
  } else {
    return '${localDate.day} $month ${localDate.year} - ${localDate.hour - 12}:${localDate.minute} pm';
  }
}

double translateX(
  double x,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
      return x *
          canvasSize.width /
          (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation270deg:
      return canvasSize.width -
          x *
              canvasSize.width /
              (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      switch (cameraLensDirection) {
        case CameraLensDirection.back:
          return x * canvasSize.width / imageSize.width;
        default:
          return canvasSize.width - x * canvasSize.width / imageSize.width;
      }
  }
}

double translateY(
  double y,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
    case InputImageRotation.rotation270deg:
      return y *
          canvasSize.height /
          (Platform.isIOS ? imageSize.height : imageSize.width);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      return y * canvasSize.height / imageSize.height;
  }
}

List<List<Transfer>> separateTransfers(List<Transfer> data) {
  var separateList = <List<Transfer>>[];
  if (data.isEmpty) {
    return separateList;
  }
  var tempList = <Transfer>[];
  tempList.add(data[0]);
  separateList.add(tempList);
  for (var i = 1; i < data.length; i++) {
    if (data[i - 1].createdAt.month == data[i].createdAt.month) {
      tempList.add(data[i]);
    } else {
      tempList = <Transfer>[];
      tempList.add(data[i]);
      separateList.add(tempList);
    }
  }
  return separateList;
}

Future<bool> saveUser(
    {required int number,
    required String email,
    required WidgetRef ref}) async {
  final prefs = ref.watch(sharedPreferencesProvider).requireValue;
  await prefs.setString('email', email);
  return await prefs.setString('qr', number.toString());
}

class NotificationPopUp extends StatelessWidget {
  const NotificationPopUp({
    super.key,
    required this.isLoading,
    required this.child,
    this.noWhite,
  });

  final bool isLoading;
  final Widget? child;
  final bool? noWhite;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Material(
        color: Colors.black.withAlpha(150),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: noWhite != null ? null : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
