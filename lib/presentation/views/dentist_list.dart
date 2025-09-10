import 'package:flutter/material.dart';

import '../../core/services/doctor_services.dart';
import '../../data/models/doctor.dart';
import 'package:toothy/presentation/views/home/view/home_screen.dart' show TopDentistCard;
import 'appointment_screen.dart';

class DentistListView extends StatefulWidget {
  const DentistListView({super.key});

  @override
  State<DentistListView> createState() => _DentistListViewState();
}

class _DentistListViewState extends State<DentistListView> {
  final doctorService = DoctorServices();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double titleFontSize = screenWidth * 0.05;
    double backFontSize = screenWidth * 0.04;
    double imageSize = screenWidth * 0.3;
    double horizontalPadding = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: const Color(0XFFE9FAFF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Kembali",
                      style: TextStyle(
                        fontSize: backFontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/DentistList.png',
                      width: imageSize,
                      height: imageSize,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Daftar Dokter",
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Doctor>>(
                  future: doctorService.getAllDoctors(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    }

                    var doctors = snapshot.data ?? [];

                    if (doctors.isEmpty) {
                      return const Center(child: Text("Tidak ada data dokter"));
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      itemCount: doctors.length,
                      itemBuilder: (context, index) {
                        final doctor = doctors[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppointmentScreen(doctor: doctor),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: TopDentistCard(
                              picture: doctor.profile_photo_url ?? "",
                              name: doctor.name,
                              specialist: doctor.specialists.isNotEmpty
                                  ? doctor.specialists.map((s) => s.title).join(", ")
                                  : "Dokter Gigi Umum",
                              experiences: doctor.years_experience.toString(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}