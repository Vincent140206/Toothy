import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70 + MediaQuery.of(context).padding.bottom,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.32, -0.00),
          end: Alignment(0.34, 1.12),
          colors: [
            const Color(0xFF007FFF),
            const Color(0xFF007FFF),
            const Color(0xFF0658AB)
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                icon: selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                label: 'Home',
                isSelected: selectedIndex == 0,
                onTap: () => onItemTapped(0),
              ),
              _buildNavItem(
                icon: selectedIndex == 1
                    ? Icons.location_on
                    : Icons.location_on_outlined,
                label: 'Klinik',
                isSelected: selectedIndex == 1,
                onTap: () => onItemTapped(1),
              ),
              const SizedBox(width: 30),
              _buildNavItem(
                icon: selectedIndex == 3 ? Icons.history : Icons.history_outlined,
                label: 'Riwayat',
                isSelected: selectedIndex == 3,
                onTap: () => onItemTapped(3),
              ),
              _buildNavItem(
                icon: selectedIndex == 4 ? Icons.person : Icons.person_outline,
                label: 'Profil',
                isSelected: selectedIndex == 4,
                onTap: () => onItemTapped(4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              height: 2,
              width: 40,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}