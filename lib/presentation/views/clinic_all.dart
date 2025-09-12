import 'package:flutter/material.dart';
import 'package:toothy/core/services/clinics_services.dart';
import 'package:toothy/data/models/clinic.dart';
import 'package:toothy/presentation/views/home/view/home_screen.dart' show ClinicListCard;

import 'home/view/widgets/clinic_list_card.dart';

class ClinicAllView extends StatefulWidget {
  const ClinicAllView({super.key});

  @override
  State<ClinicAllView> createState() => _ClinicAllViewState();
}

class _ClinicAllViewState extends State<ClinicAllView> {
  final clinicServices = ClinicsServices();

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
        child: FutureBuilder<List<Clinic>>(
          future: clinicServices.getClinics(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            var clinics = snapshot.data ?? [];
            if (clinics.isEmpty) {
              return const Center(child: Text("Tidak ada data klinik"));
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
                          "Daftar Klinik Toothy",
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
                        final clinic = clinics[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: ClinicListCard(
                            id: clinic.id,
                            photo_url: clinic.photo_url ?? "",
                            name: clinic.name,
                            address: clinic.address,
                            open_time: clinic.open_time,
                            close_time: clinic.close_time,
                            onTap: () {
                              // TODO: Navigasi ke detail
                            },
                          ),
                        );
                      },
                      childCount: clinics.length,
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
