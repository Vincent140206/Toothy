import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:toothy/core/services/clinics_services.dart';
import 'package:toothy/core/services/maps_services.dart';
import 'package:toothy/data/models/clinic.dart';

class ClinicMapView extends StatefulWidget {
  const ClinicMapView({super.key});

  @override
  State<ClinicMapView> createState() => _ClinicMapViewState();
}

class _ClinicMapViewState extends State<ClinicMapView> {
  final clinicServices = ClinicsServices();
  final mapsServices = MapsServices();
  Clinic? selectedClinic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peta Klinik Toothy"),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Clinic>>(
        future: clinicServices.getClinics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final clinics = snapshot.data ?? [];
          if (clinics.isEmpty) {
            return const Center(child: Text("Tidak ada data klinik"));
          }
          final LatLng initialCenter = LatLng(
            clinics.first.location_latitude,
            clinics.first.location_longitude,
          );

          return Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter: initialCenter,
                  initialZoom: 10,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                    "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
                    userAgentPackageName: 'com.toothy.app',
                  ),
                  MarkerLayer(
                    markers: clinics.map((clinic) {
                      return Marker(
                        point: LatLng(
                          clinic.location_latitude,
                          clinic.location_longitude,
                        ),
                        width: 80,
                        height: 80,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedClinic = clinic;
                            });
                          },
                          child: Column(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 40, color: Colors.red),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 3,
                                    )
                                  ],
                                ),
                                child: Text(
                                  clinic.name,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              if (selectedClinic != null)
                DraggableScrollableSheet(
                  initialChildSize: 0.3,
                  minChildSize: 0.2,
                  maxChildSize: 0.45,
                  builder: (context, scrollController) {
                    return NotificationListener<DraggableScrollableNotification>(
                      onNotification: (notification) {
                        if (notification.extent <= 0.21) {
                          setState(() {
                            selectedClinic = null;
                          });
                        }
                        return true;
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
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
                                selectedClinic!.photo_url,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              selectedClinic!.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(selectedClinic!.address),
                            const SizedBox(height: 8),
                            Text("Jam buka: ${selectedClinic!.open_time ?? '-'}"),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(40),
                                backgroundColor: Colors.blueAccent
                              ),
                              onPressed: () {
                                mapsServices.openGoogleMaps(
                                  selectedClinic!.location_latitude,
                                  selectedClinic!.location_longitude,
                                );
                              },
                              child: const Text("Lihat Rute", style: TextStyle(fontSize: 16, color: Colors.white),),
                            ),
                            SizedBox(height: 30,)
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}