part of '../home_screen.dart';

class _NewsSection extends StatelessWidget {
  const _NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> newsData = [
      {
        'image': 'assets/images/Article1.png',
        'category': 'Kesehatan Anak',
        'title': 'Cara Merawat Gigi Anak dengan Benar',
        'snippet': 'Kesehatan gigi anak adalah investasi untuk masa depan...',
      },
      {
        'image': 'assets/images/Article2.png',
        'category': 'Tips & Trik',
        'title': 'Perawatan Pasca-Cabut Gigi',
        'snippet': 'Harus dirawat biar gaharus cabut lagi...',
      },
      {
        'image': 'assets/images/Article3.png',
        'category': 'Tips & Trik',
        'title': 'Mengenal Root-Canal',
        'snippet': 'Yok belajar biar pinter bejir...',
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: newsData.length,
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) {
        final news = newsData[index];
        return _NewsCard(
          image: news['image']!,
          category: news['category']!,
          title: news['title']!,
          snippet: news['snippet']!,
        );
      },
    );
  }
}

class _NewsCard extends StatelessWidget {
  final String image;
  final String category;
  final String title;
  final String snippet;

  const _NewsCard({
    required this.image,
    required this.category,
    required this.title,
    required this.snippet,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              image,
              width: double.infinity,
              height: screenWidth * 0.4,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CategoryTag(category: category),
                const SizedBox(height: 8),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  snippet,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Baca Selengkapnya',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF007FFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTag extends StatelessWidget {
  final String category;
  const _CategoryTag({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF007FFF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: Color(0xFF007FFF),
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }
}

