import 'package:flutter/material.dart';

part 'widgets/home_app_bar.dart';
part 'widgets/promo_banner.dart';
part 'widgets/feature_grid.dart';
part 'widgets/news_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HomeAppBar(),
                const _PromoBanner(),
                const SizedBox(height: 30),

                // Bagian 3: Judul Layanan
                Text(
                  'Layanan Kami',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // Bagian 4: Grid Fitur Layanan
                const _FeatureGrid(),
                const SizedBox(height: 30),

                // Bagian 5: Judul Berita
                Text(
                  'Berita Terkini',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // Bagian 6: Daftar Berita
                const _NewsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
