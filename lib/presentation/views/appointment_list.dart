import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toothy/core/services/maps_services.dart';
import 'package:toothy/core/services/midtrans_services.dart';
import 'package:toothy/core/services/scan_services.dart';
import 'package:toothy/data/models/appointment.dart';
import 'package:toothy/presentation/views/home/view/widgets/custom_button.dart';
import 'package:toothy/presentation/views/toothScan/scan_result_content.dart';
import 'package:toothy/presentation/views/toothScan/scan_result_page.dart';
import '../../core/services/appointment_services.dart';
import '../../data/models/report.dart';
import '../viewmodels/appointment_viewmodel.dart';

class AppointmentList extends StatelessWidget {
  const AppointmentList({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentVM = context.watch<AppointmentViewModel>();
    final appointments = appointmentVM.appointments;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Appointment Saya"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: appointments.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: appointments.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _AppointmentCard(
          appointment: appointments[index],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy_rounded,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            "Belum ada appointment",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Jadwalkan konsultasi pertama Anda",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const _AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final statusInfo = _getStatusInfo(appointment.status);
    final isUpcoming = appointment.date?.isAfter(DateTime.now()) ?? false;
    final MidTransService midTransService = MidTransService();

    return GestureDetector(
      onTap: () async {
        try {
          final appointments = await AppointmentService().getSpecificAppointment(appointment.id);
          if (appointments != null) {
            if (appointments?.reportId == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Report gagal dimuat")),
              );
          } print(appointments.reportId);
            final report = await ScanServices.getSpecificReport(appointments.reportId!);
            Navigator.push(context, MaterialPageRoute(builder: (context) => ScanResultPage(report: report,)));
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $e")),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(statusInfo, isUpcoming),
              const SizedBox(height: 12),
              _buildContent(),
              const SizedBox(height: 12),
              _buildFooter(statusInfo),

              if ((appointment.status ?? "").toUpperCase() == "PENDING") ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff0094ff),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.payment_rounded),
                    label: const Text(
                      "Bayar Sekarang",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      final snapToken = appointment.transaction?.snapToken;
                      if (snapToken != null && snapToken.isNotEmpty) {
                        await midTransService.pay(snapToken);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("SnapToken tidak ditemukan")),
                        );
                      }
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(StatusInfo statusInfo, bool isUpcoming) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: statusInfo.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            isUpcoming ? Icons.schedule_rounded : Icons.history_rounded,
            color: statusInfo.color,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            appointment.schedule?.clinicName ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusInfo.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            statusInfo.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: statusInfo.color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _InfoRow(
          icon: Icons.person_rounded,
          label: appointment.doctorName,
        ),
        const SizedBox(height: 8),
        _InfoRow(
          icon: Icons.access_time_rounded,
          label: appointment.dateFormatted,
        ),
      ],
    );
  }

  Widget _buildFooter(StatusInfo statusInfo) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on_rounded,
            color: Colors.grey[600],
            size: 16,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              appointment.schedule?.clinic?.address ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  StatusInfo _getStatusInfo(String? status) {
    switch (status?.toUpperCase()) {
      case "CONFIRMED":
        return StatusInfo("Terkonfirmasi", Colors.blue);
      case "COMPLETED":
        return StatusInfo("Selesai", Colors.green);
      case "CANCELLED":
        return StatusInfo("Dibatalkan", Colors.red);
      default:
        return StatusInfo("Pending", Colors.orange);
    }
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey[600],
          size: 16,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class StatusInfo {
  final String label;
  final Color color;

  StatusInfo(this.label, this.color);
}