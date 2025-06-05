import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler   /permission_handler.dart';
import 'package:flutter/foundation.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription> cameras = [];
  bool _isCameraInitialized = false;
  bool _isFrontCamera = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Request camera permission
    final status = await Permission.camera.request();
    if (status.isDenied) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Camera permission is required')),
        );
      }
      return;
    }

    // Get available cameras
    cameras = await availableCameras();
    if (cameras.isEmpty) return;

    // Initialize with front camera by default
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
        // Show notification that camera is ready
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kamera siap untuk scan wajah'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('Error initializing camera: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error initializing camera: $e')),
        );
      }
    }
  }

  Future<void> _switchCamera() async {
    if (cameras.length < 2) return;

    _isFrontCamera = !_isFrontCamera;
    final newCamera = cameras.firstWhere(
      (camera) => _isFrontCamera
          ? camera.lensDirection == CameraLensDirection.front
          : camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    await _controller?.dispose();
    _controller = CameraController(
      newCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error switching camera: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error switching camera: $e')),
        );
      }
    }
  }

  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized) return;

    try {
      final XFile photo = await _controller!.takePicture();
      String resultPath;
      if (kIsWeb) {
        // On web, just use the photo path
        resultPath = photo.path;
      } else {
        final Directory appDir = await getApplicationDocumentsDirectory();
        final String dirPath = '${appDir.path}/Attendance';
        await Directory(dirPath).create(recursive: true);
        final String filePath = path.join(
          dirPath,
          'attendance_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
        await File(photo.path).copy(filePath);
        resultPath = filePath;
      }
      if (mounted) {
        // Show success notification
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Foto berhasil diambil'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        // Wait for the snackbar to be visible before closing
        await Future.delayed(const Duration(milliseconds: 500));
        Navigator.pop(context, resultPath);
      }
    } catch (e) {
      print('Error taking picture: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error taking picture: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized || _controller == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview
            Center(
              child: CameraPreview(_controller!),
            ),
            // Controls
            Positioned(
              left: 0,
              right: 0,
              bottom: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Switch Camera Button
                  if (cameras.length > 1)
                    IconButton(
                      icon: const Icon(Icons.switch_camera, size: 32),
                      color: Colors.white,
                      onPressed: _switchCamera,
                    ),
                  // Capture Button
                  FloatingActionButton(
                    onPressed: _takePicture,
                    child: const Icon(Icons.camera),
                  ),
                  // Close Button
                  IconButton(
                    icon: const Icon(Icons.close, size: 32),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}