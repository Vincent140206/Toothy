import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PreviewStep extends StatelessWidget {
  final XFile? capturedImage;
  final VoidCallback onRetake;
  final VoidCallback onNext;

  const PreviewStep({
    super.key,
    required this.capturedImage,
    required this.onRetake,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    if (capturedImage == null) {
      return const Center(child: Text("Belum ada foto"));
    }
    return Column(
      children: [
        Expanded(child: Image.file(File(capturedImage!.path))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: onRetake, child: const Text("Ulangi")),
            ElevatedButton(onPressed: onNext, child: const Text("Selanjutnya")),
          ],
        )
      ],
    );
  }
}
