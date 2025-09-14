import 'package:flutter/material.dart';
import 'package:toothy/core/services/maps_services.dart';
import 'package:toothy/data/models/clinic.dart';

class ClinicDetailSheet extends StatelessWidget {
  final Clinic clinic;
  final VoidCallback onClose;
  final MapsServices mapsServices;

  const ClinicDetailSheet({
    super.key,
    required this.clinic,
    required this.onClose,
    required this.mapsServices,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.2,
      maxChildSize: 0.45,
      builder: (context, scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            if (notification.extent <= 0.21) {
              onClose();
            }
            return true;
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                ),
              ],
            ),
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    clinic.photoUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  clinic.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(clinic.address),
                const SizedBox(height: 8),
                Text("Jam buka: ${clinic.openTime ?? '-'}"),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {
                    mapsServices.openGoogleMaps(
                      clinic.locationLatitude ?? 0,
                      clinic.locationLongitude ?? 0,
                    );
                  },
                  child: const Text(
                    "Lihat Rute",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}