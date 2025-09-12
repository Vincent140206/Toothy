import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:toothy/core/services/maps_services.dart';
import 'package:toothy/core/utils/storage_common.dart';
import 'package:toothy/data/models/clinic.dart';

import 'home/view/widgets/clinic_detail_sheet.dart';

class ClinicMapView extends StatefulWidget {
  const ClinicMapView({super.key});

  @override
  State<ClinicMapView> createState() => _ClinicMapViewState();
}

class _ClinicMapViewState extends State<ClinicMapView> {
  final MapController _mapController = MapController();
  final mapsServices = MapsServices();
  Clinic? selectedClinic;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Clinic>>(
      future: StorageCommon.getClinics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Error: ${snapshot.error}")),
          );
        }

        final clinics = snapshot.data ?? [];

        if (clinics.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("Tidak ada data klinik")),
          );
        }

        final LatLng initialCenter = LatLng(
          clinics.first.location_latitude,
          clinics.first.location_longitude,
        );

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xCC007FFF), Color(0xFF00BFFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x75000000),
                    blurRadius: 5,
                    offset: Offset(3, 3),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/LogoRS.svg",
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Cari Klinik Di Sekitarmu",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: initialCenter,
                  initialZoom: 10,
                  minZoom: 5,
                  maxZoom: 18,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                    "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=tuGG8tXFeRLJAbcqUk1g",
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
                            _mapController.move(
                              LatLng(
                                clinic.location_latitude,
                                clinic.location_longitude,
                              ),
                              _mapController.camera.zoom,
                            );
                          },
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/Pinpoint.svg",
                                height: 40,
                                width: 40,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    clinic.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                ClinicDetailSheet(
                  clinic: selectedClinic!,
                  onClose: () => setState(() => selectedClinic = null),
                  mapsServices: mapsServices,
                ),
            ],
          ),
        );
      },
    );
  }
}