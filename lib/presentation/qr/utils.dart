// import 'dart:developer';

// import 'package:camera/camera.dart';
// import 'package:image/image.dart' as imglib;

// imglib.Image imageFromBGRA8888(CameraImage image) {
//   return imglib.Image.fromBytes(
//     width: image.width,
//     height: image.height,
//     bytes: image.planes[0].bytes.buffer,
//     order: imglib.ChannelOrder.bgra,
//   );
// }

// imglib.Image imageFromYUV420(CameraImage image) {
//   final uvRowStride = image.planes[1].bytesPerRow;
//   final uvPixelStride = image.planes[1].bytesPerPixel ?? 0;
//   final img = imglib.Image(width: image.width, height: image.height);

//   // Fill image buffer with plane[0] from YUV420_888
//   for (final p in img) {
//     final x = p.x;
//     final y = p.y;
//     final uvIndex =
//         uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
//     final index = y * uvRowStride + x;
//     final yp = image.planes[0].bytes[index];
//     final up = image.planes[1].bytes[uvIndex];
//     final vp = image.planes[2].bytes[uvIndex];
//     p.r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255).toInt();
//     p.g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
//         .round()
//         .clamp(0, 255)
//         .toInt();
//     p.b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255).toInt();
//   }

//   return img;
// }

// imglib.Image? imageFromCameraImage(CameraImage image) {
//   try {
//     imglib.Image img;
//     switch (image.format.group) {
//       case ImageFormatGroup.yuv420:
//         img = imageFromYUV420(image);
//         break;
//       case ImageFormatGroup.bgra8888:
//         img = imageFromBGRA8888(image);
//         break;
//       default:
//         return null;
//     }
//     return img;
//   } catch (e) {
//     log(">>>>>>>>>>>> ERROR: + ${e.toString()}");
//   }
//   return null;
// }
