import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const CameraControlButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: backgroundColor == Colors.white.withOpacity(0.2)
              ? Colors.white
              : (backgroundColor == const Color(0xFF00BFA5)
              ? Colors.white
              : Colors.black),
          size: 24,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class CameraHeaderWidget extends StatelessWidget {
  final String title;
  final String instruction;
  final int currentPhotoIndex;

  const CameraHeaderWidget({
    super.key,
    required this.title,
    required this.instruction,
    required this.currentPhotoIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      instruction,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "Foto ${currentPhotoIndex + 1} dari 3",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CameraGuideFrame extends StatelessWidget {
  const CameraGuideFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF009DFF),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

class CameraCaptureButton extends StatelessWidget {
  final VoidCallback onTap;

  const CameraCaptureButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF0059FF),
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.camera_alt,
          color: Color(0xFF0059FF),
          size: 32,
        ),
      ),
    );
  }
}

class CameraControlsWidget extends StatelessWidget {
  final bool isFlashOn;
  final VoidCallback onToggleFlash;
  final VoidCallback onCapture;
  final VoidCallback onSwitchCamera;

  const CameraControlsWidget({
    super.key,
    required this.isFlashOn,
    required this.onToggleFlash,
    required this.onCapture,
    required this.onSwitchCamera,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, right: 24, left: 24, bottom: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CameraControlButton(
                  icon: isFlashOn ? Icons.flash_on : Icons.flash_off,
                  onPressed: onToggleFlash,
                  backgroundColor: isFlashOn
                      ? const Color(0xFF0059FF)
                      : Colors.white.withOpacity(0.2),
                ),
                CameraCaptureButton(onTap: onCapture),
                CameraControlButton(
                  icon: Icons.cameraswitch,
                  onPressed: onSwitchCamera,
                  backgroundColor: Colors.white.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}