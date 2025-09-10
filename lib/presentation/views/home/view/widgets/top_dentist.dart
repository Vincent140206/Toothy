part of '../home_screen.dart';

class _TopDentist extends StatelessWidget {
  const _TopDentist({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorService = DoctorServices();

    return FutureBuilder<List<Doctor>>(
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

        doctors = doctors.take(3).toList();

        return Column(
          children: doctors.map((doctor) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _TopDentistCard(
                picture: doctor.profile_photo_url ?? "",
                name: doctor.name,
                specialist: doctor.specialists.isNotEmpty
                    ? doctor.specialists.map((s) => s.title).join(", ")
                    : "Dokter Gigi Umum",
                experiences: doctor.years_experience.toString(),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _TopDentistCard extends StatelessWidget {
  final String picture;
  final String name;
  final String specialist;
  final String experiences;

  const _TopDentistCard({
    required this.picture,
    required this.name,
    required this.specialist,
    required this.experiences,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffE9FAFF),
            spreadRadius: 10,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              picture,
              width: screenWidth * 0.22,
              height: screenWidth * 0.22,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: screenWidth * 0.22,
                  height: screenWidth * 0.22,
                  color: Colors.grey[200],
                  child: const Icon(Icons.person, size: 40, color: Colors.grey),
                );
              },
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right_rounded,
                        color: Colors.grey.shade400, size: 30),
                  ],
                ),
                Text(
                  specialist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                    fontSize: screenWidth * 0.032,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade500),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.cases_rounded, size: 16),
                          const SizedBox(width: 4),
                          Text('$experiences tahun'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
        ],
      ),
    );
  }
}
