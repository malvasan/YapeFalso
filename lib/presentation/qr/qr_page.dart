import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';
import 'package:yapefalso/utils.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({super.key});

  @override
  ConsumerState<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> {
  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  ImagePicker? _imagePicker;
  int _cameraIndex = -1;
  bool _canProcess = true;
  bool _isBusy = false;
  bool _isValidQR = false;
  bool _cameraFlash = false;

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

//try-catch
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

  @override
  void dispose() {
    _canProcess = false;
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

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: ColoredBox(
          color: Colors.black,
          child: Stack(fit: StackFit.expand, children: [
            CameraPreview(_controller!),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: CustomPaint(
                size: MediaQuery.of(context).size,
                painter: BoxPainter(),
              ),
            ),
            Positioned(
              top: 40,
              right: 8,
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: IconButton(
                  onPressed: () => ref.read(autorouteProvider).maybePop(),
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: (size.height / 2) + (size.width / 4) + 10,
              left: (size.width / 4),
              child: SizedBox(
                height: 50,
                width: size.width / 2,
                child: const Text(
                  'Escanea un QR con tu cámara',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    if (!_cameraFlash) {
                      _controller!.setFlashMode(FlashMode.torch);
                    } else {
                      _controller!.setFlashMode(FlashMode.off);
                    }
                    _cameraFlash = !_cameraFlash;
                    setState(() {});
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white24,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                    ),
                    side: const BorderSide(width: 0),
                  ),
                  child: Text(
                    _cameraFlash ? 'Apagar Linterna' : 'Encender Linterna',
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                const Gap(30),
                Card(
                  margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: ListTile(
                    leading: Icon(
                      Icons.image_search_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: const Text('Subir una image con QR'),
                    onTap: () {
                      _getImage(ImageSource.gallery);
                    },
                  ),
                ),
                const Gap(20),
              ],
            ),
          ])),
    );
  }

  Future<void> _processCameraImage(CameraImage availableImage) async {
    final inputImage = _inputImageFromCameraImage(availableImage);

    if (inputImage == null) return;

    if (!_canProcess) return;
    if (_isBusy) return;

    _isBusy = true;
    final barcodeScanner = BarcodeScanner();
    final barcodes = await barcodeScanner.processImage(inputImage);
    var isInsideBox = false;

    for (Barcode barcode in barcodes) {
      if (barcode.format != BarcodeFormat.qrCode) continue;

      final String? rawValue = barcode.rawValue;
      //_isValidQR to stop proccesing QR when there is already a valid one
      if (_isValidQR) continue;
      //verify that is inside the box in the middle
      if (inputImage.metadata?.size != null &&
          inputImage.metadata?.rotation != null) {
        if (!mounted) {
          continue;
        }
        final size = MediaQuery.of(context).size;
        isInsideBox = verifyQRBox(
            barcode: barcode,
            size: size,
            imageSize: inputImage.metadata!.size,
            rotation: inputImage.metadata!.rotation,
            cameraLensDirection: CameraLensDirection.back);
      }

      if (isInsideBox) {
        final validFormat = RegExp(r'^(YP-)\d{9}');
        if (validFormat.hasMatch(rawValue ?? '')) {
          _isValidQR = true;
          changePage(barcode.displayValue, ref);
        }
      }
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  void changePage(String? phone, WidgetRef ref) async {
    if (phone == null) {
      return;
    }

    //temp help us when we return from the payment and we want to continue scanning
    var temp = await ref.read(autorouteProvider).push<bool>(PaymentRoute(
          phone: int.parse(phone.replaceAll('YP-', '')),
        ));
    if (temp != null) {
      _isValidQR = temp;
      _cameraFlash = temp;
    }
  }

  //this function calculate the points of the box in the middle taking in count the size of the device
  //after that evaluate if the QR is inside the box
  bool verifyQRBox(
      {required Barcode barcode,
      required Size size,
      required Size imageSize,
      required InputImageRotation rotation,
      required CameraLensDirection cameraLensDirection}) {
    final List<Offset> cornerPoints = <Offset>[];
    for (final point in barcode.cornerPoints) {
      final double x = translateX(
        point.x.toDouble(),
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final double y = translateY(
        point.y.toDouble(),
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      cornerPoints.add(Offset(x, y));
    }

    final distanceBox = size.width / 2;
    final boxCenterPoint = Offset(size.width / 2, size.height / 2);

    final boxPositiveX = boxCenterPoint.dx + distanceBox / 2;
    final boxPositiveY = boxCenterPoint.dy + distanceBox / 2;
    final boxNegativeX = boxCenterPoint.dx - distanceBox / 2;
    final boxNegativeY = boxCenterPoint.dy - distanceBox / 2;

    final boxTL = Offset(boxNegativeX, boxNegativeY);
    final boxTR = Offset(boxPositiveX, boxNegativeY);
    final boxBL = Offset(boxNegativeX, boxPositiveY);
    final boxBR = Offset(boxPositiveX, boxPositiveY);

    final evaluateTL =
        (boxTL.dx <= cornerPoints[0].dx) && (boxTL.dy <= cornerPoints[0].dy);

    final evaluateTR =
        (boxTR.dx >= cornerPoints[1].dx) && (boxTR.dy <= cornerPoints[1].dy);

    final evaluateBR =
        (boxBR.dx >= cornerPoints[2].dx) && (boxBR.dy >= cornerPoints[2].dy);

    final evaluateBL =
        (boxBL.dx <= cornerPoints[3].dx) && (boxBL.dy >= cornerPoints[3].dy);

    if (evaluateTL && evaluateTR && evaluateBR && evaluateBL) {
      return true;
    }
    return false;
  }

  //transformation needed from the streaming to verify is there is a QR
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

  //this function trigger when the user upload an image from the gallery
  //the main diffrence is that we should verify that the image is not to large to be proccesed
  //after that is the same as the used in the live camera without the necessity to be inside the box
  Future _getImage(ImageSource source) async {
    _imagePicker = ImagePicker();
    final pickedFile = await _imagePicker!
        .pickImage(source: source, maxHeight: 1080, maxWidth: 2248);

    if (pickedFile != null) {
      final inputImage = InputImage.fromFilePath(pickedFile.path);

      _isBusy = false;
      if (!_canProcess) return;
      if (_isBusy) return;

      _isBusy = true;

      final barcodeScanner = BarcodeScanner();
      final barcodes = await barcodeScanner.processImage(inputImage);

      for (Barcode barcode in barcodes) {
        if (barcode.format != BarcodeFormat.qrCode) continue;

        final String? rawValue = barcode.rawValue;

        final validFormat = RegExp(r'^(YP-)\d{9}');
        if (validFormat.hasMatch(rawValue ?? '')) {
          changePage(barcode.displayValue, ref);
        }
      }
      _isBusy = false;
      if (mounted) {
        setState(() {});
      }
    }
  }
}

class BoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black54;
    Paint paintBox = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = Colors.white;
    final distance = size.width / 2;
    final boxCenterPoint = Offset(size.width / 2, size.height / 2);
    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          Path()
            ..addRRect(
              RRect.fromRectAndRadius(
                Rect.fromCenter(
                    center: boxCenterPoint, width: distance, height: distance),
                const Radius.circular(15),
              ),
            )
            ..close(),
        ),
        paint);
    Path path = Path();

    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: boxCenterPoint, width: distance, height: distance),
      const Radius.circular(15),
    ));

    path.close();
    canvas.drawPath(path, paintBox);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
