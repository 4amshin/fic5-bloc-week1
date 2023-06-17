// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  final Function(XFile) takePicture;
  final List<CameraDescription>? cameras;

  const CameraPage({
    Key? key,
    required this.takePicture,
    this.cameras,
  }) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;

  XFile? captureImage;

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      _cameraController.setFlashMode(FlashMode.torch);
      XFile image = await _cameraController.takePicture();
      _cameraController.setFlashMode(FlashMode.off);

      widget.takePicture(image);
      Navigator.pop(context);
    } on CameraException catch (e) {
      log('Error When Taking Picture: $e');
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessedDenied':
            //handle access errors here.
            break;
          default:
            //handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return const SizedBox();
    }
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CameraPreview(_cameraController),
            ElevatedButton(
              onPressed: () => takePicture(),
              child: const Text("Jepret"),
            ),
          ],
        ),
      ],
    );
  }
}
