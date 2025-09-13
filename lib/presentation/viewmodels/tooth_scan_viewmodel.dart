import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../core/services/scan_services.dart';
import '../../data/models/report.dart';

class ToothScanViewModel extends ChangeNotifier {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  List<Report> reports = [];
  bool isLoading = false;
  String? errorMessage;

  Report? _report;
  Report? get report => _report;

  int _currentStep = 1;
  List<XFile> _capturedImages = [];
  bool _isFlashOn = false;
  int _currentPhotoIndex = 0;
  bool isUploading = false;

  CameraController? get controller => _controller;
  Future<void>? get initializeControllerFuture => _initializeControllerFuture;
  int get currentStep => _currentStep;
  List<XFile> get capturedImages => _capturedImages;
  bool get isFlashOn => _isFlashOn;
  int get currentPhotoIndex => _currentPhotoIndex;

  List<String> get photoTitles => ScanServices.photoTitles;
  List<String> get photoInstructions => ScanServices.photoInstructions;

  ToothScanViewModel() {
    _capturedImages = List.filled(3, XFile(''), growable: false);
    _setupCamera();
  }

  Future<void> _setupCamera({
    CameraLensDirection direction = CameraLensDirection.front,
  }) async {
    final newController = await ScanServices.setupCamera(direction: direction);
    if (newController != null) {
      await _controller?.dispose();

      _controller = newController;
      _initializeControllerFuture = _controller!.initialize();
      notifyListeners();
    }
  }

  void nextStep() {
    _currentStep++;
    notifyListeners();
  }

  void resetCapture() {
    _capturedImages[_currentPhotoIndex] = XFile('');
    _currentStep = 2;
    notifyListeners();
  }

  void startScan() {
    _currentStep = 2;
    _currentPhotoIndex = 0;
    notifyListeners();
  }

  Future<void> toggleFlash() async {
    if (_controller != null) {
      _isFlashOn = await ScanServices.toggleFlash(_controller!, _isFlashOn);
      notifyListeners();
    }
  }

  void goToFinalPreview() {
    _currentStep = 4;
    _disposeCamera();
    notifyListeners();
  }

  Future<void> disposeCamera() async {
    await _disposeCamera();
  }

  Future<void> _disposeCamera() async {
    try {
      if (_controller != null) {
        await _controller!.dispose();
        _controller = null;
        _initializeControllerFuture = null;
        print("Camera disposed successfully");
      }
    } catch (e) {
      print("Error disposing camera: $e");
    }
  }

  void goToPhotoCapture(int index) {
    _currentPhotoIndex = index;
    _currentStep = 2;

    if (_controller == null) {
      _setupCamera();
    }

    notifyListeners();
  }
  Future<void> restartCamera({CameraLensDirection direction = CameraLensDirection.front}) async {
    await _disposeCamera();
    await _setupCamera(direction: direction);
  }

  Future<void> takePicture() async {
    if (_controller != null) {
      final image = await ScanServices.takePicture(_controller!);
      if (image != null) {
        _capturedImages[_currentPhotoIndex] = image;
        _currentStep = 3;
        notifyListeners();
      }
    }
  }

  Future<void> switchCamera() async {
    if (_controller != null) {
      final currentLens = _controller!.description.lensDirection;
      final newDirection = currentLens == CameraLensDirection.front
          ? CameraLensDirection.back
          : CameraLensDirection.front;
      await _setupCamera(direction: newDirection);
    }
  }

  void moveToNextPhoto() {
    if (_currentPhotoIndex < 2) {
      _currentPhotoIndex++;
      _currentStep = 2;
    } else {
      goToFinalPreview();
    }
    notifyListeners();
  }

  void resetAll() {
    _disposeCamera();

    _currentStep = 1;
    _currentPhotoIndex = 0;
    _capturedImages = List.filled(3, XFile(''), growable: false);
    notifyListeners();
  }


  Future<Report?> sendPicture(List<String> images) async {
    try {
      final result = await ScanServices.sendPictures(images);
      _report = result;
      notifyListeners();
      return result;
    } catch (e) {
      debugPrint("Upload gagal: $e");
      return null;
    }
  }

  String getCurrentTitle() {
    return ScanServices.getCurrentTitle(_currentStep, _currentPhotoIndex);
  }

  String getCurrentSubtitle() {
    return ScanServices.getCurrentSubtitle(_currentStep, _currentPhotoIndex);
  }

  Future<void> fetchReports() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      reports = await ScanServices.getReports();

      if (reports.isEmpty) {
        errorMessage = "Belum ada laporan";
      }
    } catch (e) {
      errorMessage = "Gagal memuat laporan";
      debugPrint("fetchReports error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposeCamera();
    super.dispose();
  }
}