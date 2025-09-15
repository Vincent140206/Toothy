import 'package:flutter/material.dart';
import '../../core/utils/user_storage.dart';
import '../../data/models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: FutureBuilder<User?>(
          future: UserStorage.getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF1E88E5),
                ),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Gagal memuat data user',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            final user = snapshot.data;

            if (user == null) {
              return const Center(
                child: Text('Data user tidak ditemukan'),
              );
            }

            return Column(
              children: [
                const SizedBox(height: 60),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFF1E88E5),
                    backgroundImage: user.photoUrl != null && user.photoUrl!.isNotEmpty
                        ? NetworkImage(user.photoUrl!)
                        : null,
                    child: user.photoUrl == null || user.photoUrl!.isEmpty
                        ? Text("Kaga Ada")
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                Text(user.fullName ?? '', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Text('Dental Lover 🦷', style: TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 40),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      _card(user.email ?? 'Email tidak tersedia'),
                      _card(user.phoneNumber ?? 'Nomor HP tidak tersedia'),
                      _card(user.birthDate ?? ''),
                      _card(user.password ?? ''),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _card(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 15, color: Colors.black87)),
    );
  }
}