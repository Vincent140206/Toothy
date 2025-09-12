import 'package:flutter/material.dart';
import '../../../data/models/report.dart';

class ScanResultPage extends StatelessWidget {
  final Report report;

  const ScanResultPage({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Hasil Scan Gigi"), backgroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Foto Gigi", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildImage(report.frontTeethPhotoUrl, "Depan"),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildImage(report.upperTeethPhotoUrl, "Atas"),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildImage(report.lowerTeethPhotoUrl, "Bawah"),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text("Ringkasan", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(report.summary),

            const SizedBox(height: 16),

            Text("Rekomendasi Layanan",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Column(
              children: report.recommendations.map((rec) {
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(rec.name),
                    subtitle: Text(rec.description),
                    trailing: Text(
                      "Rp ${rec.startEstimatedPrice} - Rp ${rec.endEstimatedPrice}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String? url, String label) {
    if (url == null) {
      return Container(
        height: 100,
        color: Colors.grey[300],
        child: Center(child: Text("Tidak ada foto\n($label)")),
      );
    }
    return Image.network(
      url,
      height: 100,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        height: 100,
        color: Colors.grey[300],
        child: Center(child: Text("Gagal load\n($label)")),
      ),
    );
  }
}
