import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:yapefalso/domain/transfer.dart';

enum Months { en, feb, mar, abr, may, jun, jul, ag, set, oct, nov, dic }

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
