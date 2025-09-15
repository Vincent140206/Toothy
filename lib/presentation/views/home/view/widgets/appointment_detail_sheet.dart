import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toothy/data/models/appointment.dart';

class AppointmentDetailSheet extends StatefulWidget {
  final Appointment appointment;
  final VoidCallback onClose;

  const AppointmentDetailSheet({
    super.key,
    required this.appointment,
    required this.onClose,
  });

  @override
  State<AppointmentDetailSheet> createState() => _AppointmentDetailSheetState();
}

class _AppointmentDetailSheetState extends State<AppointmentDetailSheet> {
  bool isClosed = false;

  @override
  Widget build(BuildContext context) {
    final formattedDate = widget.appointment.date != null
        ? DateFormat('dd MMMM yyyy, HH:mm').format(widget.appointment.date!)
        : "-";

    final clinicInfo = [
      widget.appointment.schedule?.clinicName,
      widget.appointment.schedule?.clinic?.address
    ].where((e) => e != null && e.isNotEmpty).join('\n');

    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.25,
      maxChildSize: 0.65,
      builder: (context, scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            if (!isClosed && notification.extent <= 0.26) {
              isClosed = true;
              widget.onClose();
            }
            return true;
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40)),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      margin: const EdgeInsets.only(top: 12, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        children: [
                          const Text(
                            "Detail Appointment",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildInfoCard(
                            icon: Icons.local_hospital_rounded,
                            title: "Klinik",
                            value: clinicInfo.isNotEmpty ? clinicInfo : "-",
                          ),
                          const SizedBox(height: 12),
                          _buildInfoCard(
                            icon: Icons.person_outline,
                            title: "Dokter",
                            value: widget.appointment.doctorName ?? "-",
                          ),
                          const SizedBox(height: 12),
                          _buildInfoCard(
                            icon: Icons.access_time_outlined,
                            title: "Tanggal & Waktu",
                            value: formattedDate,
                          ),
                          const SizedBox(height: 12),
                          _buildInfoCard(
                            icon: Icons.info_outline,
                            title: "Status",
                            value: widget.appointment.status ?? "-",
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: widget.onClose,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Tutup",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

    Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blueAccent,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}