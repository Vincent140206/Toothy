import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toothy/core/widgets/loading_screen.dart';
import 'package:toothy/presentation/views/clinic_map_view.dart';
import 'package:toothy/presentation/views/home/view/widgets/bottom_navbar.dart';
import 'package:toothy/presentation/views/toothScan/scan_result_screen.dart';
import 'package:toothy/presentation/views/toothScan/tooth_scan_screen.dart';
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
    const ClinicMapView(),
    const ToothScanScreen(),
    const ScanResultScreen(),
    const LoadingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final fabSize = screenWidth * 0.23;
    final fabIconSize = screenWidth * 0.1;
    final fabOffset = screenHeight * 0.012;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: Transform.translate(
        offset: Offset(0, fabOffset),
        child: SizedBox(
          width: fabSize,
          height: fabSize,
          child: FloatingActionButton(
            onPressed: () => _onItemTapped(2),
            backgroundColor: Colors.white,
            shape: const CircleBorder(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Scan.svg',
                  width: fabIconSize,
                ),
                Text("TOOTH SCAN", style: TextStyle(color: Colors.black, fontSize: 12),)
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}