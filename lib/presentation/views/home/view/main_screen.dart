import 'package:flutter/material.dart';
import 'package:toothy/presentation/views/home/view/widgets/bottom_navbar.dart';
import '../../main/placeholder_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    const PlaceholderScreen(title: 'Jadwal'),
    const PlaceholderScreen(title: 'Riwayat'),
    const PlaceholderScreen(title: 'Toko'),
    const PlaceholderScreen(title: 'Profil'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

