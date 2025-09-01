part of '../home_screen.dart';

class _TopDentist extends StatelessWidget {
  const _TopDentist({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dentists = [
      {
        'picture': 'assets/images/Dentist1.png',
        'name': 'Drg. Ali Subagyo',
        'specialist': 'Scaling, Tambal Gigi, Cabut Gigi',
        'rating': '95',
        'experiences': '6',
      },
      {
        'picture': 'assets/images/Dentist2.png',
        'name': 'Drg. Lina Rosalita',
        'specialist': 'Scaling, Tambal Gigi',
        'rating': '95',
        'experiences': '8',
      },
      {
        'picture': 'assets/images/Dentist3.png',
        'name': 'Dr. Siwon Suhendri',
        'specialist': 'Gigi Palsu, Behel',
        'rating': '95',
        'experiences': '5',
      },
    ];
    return Column(
      children: dentists.map((dentistData) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _TopDentistCard(
            picture: dentistData['picture'],
            name: dentistData['name'],
            specialist: dentistData['specialist'],
            rating: dentistData['rating'],
            experiences: dentistData['experiences'],
          ),
        );
      }).toList(),
    );
  }
}

class _TopDentistCard extends StatelessWidget {
  final String picture;
  final String name;
  final String specialist;
  final String rating;
  final String experiences;

  const _TopDentistCard({
    required this.picture,
    required this.name,
    required this.specialist,
    required this.rating,
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
            color: Color(0xffE9FAFF),
            spreadRadius: 10,
            blurRadius: 10,
            offset: const Offset(0,4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              picture,
              width: screenWidth * 0.22,
              height: screenWidth * 0.22,
              fit: BoxFit.cover,
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
                    Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400, size: 30),
                  ],
                ),
                Text(
                  specialist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                    fontSize: screenWidth * 0.032,
                    fontStyle: FontStyle.italic
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade500),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.cases_rounded, size: 16),
                          SizedBox(width: 4),
                          Text('$experiences tahun'),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade500),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.thumb_up_alt_rounded, size: 16),
                          SizedBox(width: 4),
                          Text('$rating%'),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
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
