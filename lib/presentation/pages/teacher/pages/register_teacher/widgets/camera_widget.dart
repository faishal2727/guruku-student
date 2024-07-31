// ignore_for_file: use_super_parameters

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({
    Key? key,
    required this.cameras,
  }) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  State<CameraWidget> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraWidget> with WidgetsBindingObserver {
  bool _isCameraInitialized = false;
  CameraController? controller;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // Pilih kamera belakang saat inisialisasi
    onNewCameraSelected(
      widget.cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back)
    );
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    final cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );
    await previousCameraController?.dispose();

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera $e');
    }

    if (mounted) {
      setState(() {
        controller = cameraController;
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ambil Gambar"),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              _isCameraInitialized
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        CameraPreview(controller!),
                        _buildGuidedSquare(context),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              Align(
                alignment: const Alignment(0, 0.95),
                child: _actionWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuidedSquare(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      height: screenSize.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/subs.png'), // Sesuaikan dengan path gambar Anda
          fit: BoxFit.cover, // Sesuaikan dengan kebutuhan Anda
        ),
      ),
    );
  }

  Widget _actionWidget() {
    return FloatingActionButton(
      heroTag: "take-picture",
      tooltip: "Ambil Gambar",
      onPressed: () => _onCameraButtonClick(),
      child: const Icon(Icons.camera_alt),
    );
  }

  Future<void> _onCameraButtonClick() async {
    final navigator = Navigator.of(context);
    final image = await controller?.takePicture();

    navigator.pop(image);
  }
}