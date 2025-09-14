import 'package:flutter/material.dart';
import '../../core/services/doctor_services.dart';
import '../../data/models/doctor.dart';
import 'package:toothy/presentation/views/home/view/home_screen.dart'
    show TopDentistCard;
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
      body: SafeArea(
        child: FutureBuilder<List<Doctor>>(
          future: doctorService.getAllDoctors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            var doctors = snapshot.data ?? [];
            if (doctors.isEmpty) {
              return const Center(child: Text("Tidak ada data dokter"));
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding / 2,
                      vertical: 20,
                    ),
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
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/DentistList.png',
                          width: imageSize,
                          height: imageSize,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Daftar Dokter Toothy",
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final doctor = doctors[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: TopDentistCard(
                            picture: doctor.profilePhotoUrl ?? "",
                            name: doctor.name,
                            specialist: doctor.specialists.isNotEmpty
                                ? doctor.specialists
                                .map((s) => s?.title)
                                .join(", ")
                                : "Dokter Gigi Umum",
                            experiences: doctor.yearsExperience.toString(),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AppointmentScreen(doctor: doctor, clinicName: doctor.clinic?.name ?? "Klinik tidak diketahui", scheduleId: doctor.scheduleId ?? ''),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      childCount: doctors.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}