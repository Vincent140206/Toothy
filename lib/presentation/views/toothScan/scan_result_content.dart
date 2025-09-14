import 'package:flutter/material.dart';

import '../../../data/models/report.dart';
class ScanResultContent extends StatelessWidget {
  final Report report;

  const ScanResultContent({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            height: 5,
            width: 50,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Text(
          "Detail Appointment",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text("Report ID: ${report.id}"),
        const SizedBox(height: 8),
        Text("Diagnosis: ${report.summary ?? '-'}"),
        const SizedBox(height: 8),
        Text("Rekomendasi: ${report.recommendations ?? '-'}"),
        const SizedBox(height: 16),
        if (report.lowerTeethPhotoUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              report.lowerTeethPhotoUrl!,
              fit: BoxFit.cover,
            ),
          ),
        const SizedBox(height: 16),
        if (report.upperTeethPhotoUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              report.upperTeethPhotoUrl!,
              fit: BoxFit.cover,
            ),
          ),
        const SizedBox(height: 16),
        if (report.frontTeethPhotoUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              report.frontTeethPhotoUrl!,
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }
}