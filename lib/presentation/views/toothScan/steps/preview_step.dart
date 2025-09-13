import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PreviewStep extends StatelessWidget {
  final XFile? capturedImage;
  final VoidCallback onRetake;
  final VoidCallback onNext;
  final bool isProcessing;
  final String? photoTitle;

  const PreviewStep({
    super.key,
    required this.capturedImage,
    required this.onRetake,
    required this.onNext,
    this.isProcessing = false,
    this.photoTitle,
  });

  @override
  Widget build(BuildContext context) {
    if (capturedImage == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text("Belum ada foto", style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Photo title if provided
        if (photoTitle != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              photoTitle!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),

        Expanded(
          flex: 8,
          child: Center(
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(capturedImage!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (isProcessing)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Colors.white),
                            SizedBox(height: 16),
                            Text(
                              "Memproses foto...",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isProcessing ? null : onRetake,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Ulangi"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isProcessing ? null : onNext,
                    icon: isProcessing
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Icon(Icons.arrow_forward),
                    label: Text(isProcessing ? "Processing..." : "Selanjutnya"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}