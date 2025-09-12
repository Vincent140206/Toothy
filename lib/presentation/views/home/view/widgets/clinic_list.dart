part of '../home_screen.dart';

class _ClinicList extends StatelessWidget {
  final int count;
  const _ClinicList({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final clinicService = ClinicsServices();

    return FutureBuilder<List<Clinic>>(
      future: clinicService.getClinics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        var clinics = snapshot.data ?? [];

        if (clinics.isEmpty) {
          return const Center(child: Text("Tidak ada data dokter"));
        }

        Future.microtask(() async {
          await StorageCommon.saveClinics(clinics);
        });

        var displayClinics = clinics.take(count).toList();

        return Column(
          children: displayClinics.map((clinics) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ClinicListCard(

                photo_url: clinics.photo_url ?? "",
                name: clinics.name,
                address: clinics.address,
                open_time: clinics.open_time,
                close_time: clinics.close_time,
                id: clinics.id,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => AppointmentScreen(doctor: doctor),
                  //   ),
                  // );
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}