part of '../home_screen.dart';

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final List<Map<String, dynamic>> features = [
      {'icon': Icons.chat_bubble_outline, 'label': 'Konsultasi'},
      {'icon': Icons.article_outlined, 'label': 'Artikel'},
      {'icon': Icons.store_outlined, 'label': 'Toko'},
      {'icon': Icons.calendar_today_outlined, 'label': 'Janji Temu'},
      {'icon': Icons.video_call_outlined, 'label': 'Video Call'},
      {'icon': Icons.location_on_outlined, 'label': 'Klinik'},
      {'icon': Icons.medical_services_outlined, 'label': 'Obat'},
      {'icon': Icons.more_horiz_outlined, 'label': 'Lainnya'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: screenWidth * 0.04,
        mainAxisSpacing: screenWidth * 0.04,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return _FeatureCard(
          icon: features[index]['icon'],
          label: features[index]['label'],
        );
      },
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            color: const Color(0xFF007FFF).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF007FFF), size: screenWidth * 0.07),
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: screenWidth * 0.03,
          ),
        ),
      ],
    );
  }
}

