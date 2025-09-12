import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toothy/presentation/views/toothScan/scan_result_page.dart';
import '../../viewmodels/tooth_scan_viewmodel.dart';

class ScanResultScreen extends StatelessWidget {
  const ScanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ToothScanViewModel()..fetchReports(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Hasil Scan Gigi"), backgroundColor: Colors.white,),
        backgroundColor: Colors.white,
        body: Consumer<ToothScanViewModel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.errorMessage != null) {
              return Center(child: Text(vm.errorMessage!));
            }

            return ListView.builder(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
              itemCount: vm.reports.length,
              itemBuilder: (context, index) {
                final report = vm.reports[index];
                return Card(
                  color: Colors.white,
                  shadowColor: Colors.grey,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          "Laporan ${index + 1}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          report.summary,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ScanResultPage(report: report),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: Text(
                          "Dibuat pada: ${report.createdAt.toLocal().toString().split(' ')[0]}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}