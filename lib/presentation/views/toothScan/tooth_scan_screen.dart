import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:toothy/presentation/views/toothScan/scan_result_screen.dart';
import 'package:toothy/presentation/views/toothScan/steps/camera_step.dart';
import 'package:toothy/presentation/views/toothScan/steps/instruction_step.dart';
import 'package:toothy/presentation/views/toothScan/steps/step_indicator.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/tooth_scan_viewmodel.dart';
import '../home/view/widgets/custom_button.dart';

class ToothScanScreen extends StatefulWidget {
  const ToothScanScreen({super.key});

  @override
  State<ToothScanScreen> createState() => _ToothScanScreenState();
}

class _ToothScanScreenState extends State<ToothScanScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ToothScanViewModel(),
      child: Consumer<ToothScanViewModel>(
        builder: (context, viewModel, child) {
          Widget body;
          if (viewModel.currentStep == 1) {
            body = _buildInstructionStep(viewModel);
          } else if (viewModel.currentStep == 2) {
            body = _buildCameraStep(viewModel);
          } else if (viewModel.currentStep == 3) {
            body = _buildPreviewStep(viewModel);
          } else {
            body = _buildFinalPreviewStep(viewModel);
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: body,
          );
        },
      ),
    );
  }

  Widget _buildInstructionStep(ToothScanViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.grey.shade50,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                viewModel.getCurrentTitle(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                viewModel.getCurrentSubtitle(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              StepIndicatorWidget(currentStep: viewModel.currentStep),
              const InstructionCard(),
              const SizedBox(height: 20),
              Text(
                "Contoh Pengambilan Gambar yang Benar:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ExampleImageWidget(emoji: "🦷", label: "Posisi 1"),
                  ExampleImageWidget(emoji: "🦷", label: "Posisi 2"),
                  ExampleImageWidget(emoji: "🦷", label: "Posisi 3"),
                ],
              ),
              const Spacer(),
              AnimatedStartButton(
                text: "MULAI SCAN",
                scaleAnimation: _scaleAnimation,
                onPressed: () {
                  _animationController.forward().then((_) {
                    _animationController.reverse();
                    viewModel.startScan();
                  });
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraStep(ToothScanViewModel viewModel) {
    if (viewModel.controller == null) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00BFA5)),
        ),
      );
    }

    return FutureBuilder(
      future: viewModel.initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              Positioned.fill(
                child: CameraPreview(viewModel.controller!),
              ),

              CameraHeaderWidget(
                title: viewModel.photoTitles[viewModel.currentPhotoIndex],
                instruction: viewModel.photoInstructions[viewModel.currentPhotoIndex],
                currentPhotoIndex: viewModel.currentPhotoIndex,
              ),

              const CameraGuideFrame(),

              CameraControlsWidget(
                isFlashOn: viewModel.isFlashOn,
                onToggleFlash: () => viewModel.toggleFlash(),
                onCapture: () async {
                  await viewModel.takePicture();
                },
                onSwitchCamera: () => viewModel.switchCamera(),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00BFA5)),
            ),
          );
        }
      },
    );
  }

  Widget _buildPreviewStep(ToothScanViewModel viewModel) {
    if (viewModel.capturedImages[viewModel.currentPhotoIndex].path.isEmpty) {
      return const Center(
        child: Text("Belum ada foto"),
      );
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.shade50,
            Colors.white,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Preview ${viewModel.photoTitles[viewModel.currentPhotoIndex]}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Foto ${viewModel.currentPhotoIndex + 1} dari 3",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(viewModel.capturedImages[viewModel.currentPhotoIndex].path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: SecondaryButton(
                        text: "Ambil Ulang",
                        onPressed: () => viewModel.resetCapture(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: GradientButton(
                        text: viewModel.currentPhotoIndex < 2 ? "Selanjutnya" : "Selesai",
                        onPressed: () => viewModel.moveToNextPhoto(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFinalPreviewStep(ToothScanViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.shade50,
            Colors.white,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Preview Semua Hasil Scan",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Pastikan semua foto sudah sesuai sebelum mengirim",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viewModel.photoTitles[index],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: viewModel.capturedImages[index].path.isNotEmpty
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(viewModel.capturedImages[index].path),
                                fit: BoxFit.cover,
                              ),
                            )
                                : Center(
                              child: Text(
                                "Foto tidak tersedia",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => viewModel.goToPhotoCapture(index),
                                child: const Text(
                                  "Ambil Ulang",
                                  style: TextStyle(
                                    color: Color(0xFF00BFA5),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: SecondaryButton(
                        text: "Mulai Ulang",
                        onPressed: viewModel.isUploading ? null : () => viewModel.resetAll(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: GradientButton(
                        text: "Kirim & Analisis",
                        isLoading: viewModel.isUploading,
                          onPressed: () async {
                            final images = viewModel.capturedImages
                                .map((xfile) => xfile.path)
                                .where((path) => path.isNotEmpty)
                                .toList();

                            final report = await context
                                .read<ToothScanViewModel>()
                                .sendPicture(images);

                            if (report != null && context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ScanResultScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Gagal mengirim foto")),
                              );
                            }
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}