import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';

@RoutePage()
class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  bool _canProcess = true;
  bool _isBusy = false;
  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == CameraLensDirection.back) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  Future _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   controller = CameraController(
  //     cameras[0],
  //     ResolutionPreset.high,
  //     enableAudio: false,
  //     imageFormatGroup: Platform.isAndroid
  //         ? ImageFormatGroup.nv21 // for Android
  //         : ImageFormatGroup.bgra8888,
  //   );

  //   controller.initialize().then((_) async {
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() {});

  //     await controller.startImageStream(processCameraImage);
  //   }).catchError((Object e) {
  //     if (e is CameraException) {
  //       switch (e.code) {
  //         case 'CameraAccessDenied':
  //           // Handle access errors here.
  //           break;
  //         default:
  //           // Handle other errors here.
  //           break;
  //       }
  //     }
  //   });
  // }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  @override
  Widget build(BuildContext context) {
    if (_cameras.isEmpty) return Container();
    if (_controller == null) return Container();
    if (_controller?.value.isInitialized == false) {
      return Container();
    }

    return MaterialApp(
      home: CameraPreview(_controller!),
    );
  }

  //YP-USERID
  //YP-numero de telefono
  //expresiones regulares( verificar qr)
  //numeros unicos asociados

  Future<void> _processCameraImage(CameraImage availableImage) async {
    final inputImage = _inputImageFromCameraImage(availableImage);

    if (inputImage == null) return;

    if (!_canProcess) return;
    if (_isBusy) return;

    _isBusy = true;
    final barcodeScanner = BarcodeScanner();
    final barcodes = await barcodeScanner.processImage(inputImage);
    //vission detector view
    //barcode scanner, camera view
    for (Barcode barcode in barcodes) {
      if (barcode.format != BarcodeFormat.qrCode) continue;
      final BarcodeType type = barcode.type;
      final Rect boundingBox = barcode.boundingBox;
      final String? displayValue = barcode.displayValue;
      final String? rawValue = barcode.rawValue;
      final validFormat = RegExp(r'^(YP-)\d{9}');
      if (!validFormat.hasMatch(rawValue ?? ''))
        break;
      else {
        changePage();
      }
      log('inputImage');
      log(inputImage.bytes.toString());
      log('format');
      log(barcode.format.toString());
      log('displayValue');
      log(displayValue ?? '');
      log('boundingBox');
      log(boundingBox.toString());
      log('rawValue');
      log(rawValue ?? '');
      // See API reference for complete list of supported types
      // switch (type) {
      //   case BarcodeType.wifi:
      //     final barcodeWifi = barcode.value as BarcodeWifi;
      //     break;
      //   case BarcodeType.url:
      //     final barcodeUrl = barcode.value as BarcodeUrl;
      //     break;
      //   case BarcodeType.unknown:
      //     break;
      //   default:
      //     break;
      // }
    }
    _isBusy = false;
  }

  void changePage() {
    context.router.push(const PaymentRoute());
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas

    final camera = _cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[_controller?.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }

    if (rotation == null) return null;

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS

    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }
}
