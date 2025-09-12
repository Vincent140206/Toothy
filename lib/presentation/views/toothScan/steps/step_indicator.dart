import 'package:flutter/material.dart';

class StepIndicatorWidget extends StatelessWidget {
  final int currentStep;

  const StepIndicatorWidget({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          final step = index + 1;
          final isActive = step == currentStep;
          final isDone = step < currentStep;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 6),
            width: isActive ? 36 : 32,
            height: isActive ? 36 : 32,
            decoration: BoxDecoration(
              color: isDone
                  ? const Color(0xFF00BFA5)
                  : isActive
                  ? const Color(0xFF00BFA5)
                  : Colors.grey.shade300,
              shape: BoxShape.circle,
              boxShadow: isActive
                  ? [
                BoxShadow(
                  color: const Color(0xFF00BFA5).withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                )
              ]
                  : null,
            ),
            child: Center(
              child: isDone
                  ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 18,
              )
                  : Text(
                "$step",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive || isDone
                      ? Colors.white
                      : Colors.grey.shade600,
                  fontSize: isActive ? 16 : 14,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}