import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toothy/presentation/viewmodels/tooth_scan_viewmodel.dart';
import 'package:toothy/presentation/views/auth/view/login_screen.dart';
import 'package:toothy/presentation/views/auth/view/register_screen.dart';
import 'package:toothy/presentation/views/clinic_all.dart';
import 'package:toothy/presentation/views/clinic_selection.dart';
import 'package:toothy/presentation/views/dentist_list.dart';
import 'package:toothy/presentation/views/home/view/home_screen.dart';
import 'package:toothy/presentation/views/home/view/main_screen.dart';
import 'package:toothy/presentation/views/clinic_map_view.dart';
import 'package:toothy/presentation/views/onboarding/view/onboarding_view.dart';
import 'package:toothy/presentation/views/splashscreen/splashscreen_view.dart';

import 'data/models/report.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ToothScanViewModel()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: const MyApp(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashscreenView(),
        '/onboarding': (context) => const OnboardingView(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/main': (context) => const MainScreen(),
        '/dentist-list': (context) => const DentistListView(),
        '/clinic-list': (context) => const ClinicAllView(),
        '/maps': (context) => const ClinicMapView(),
        '/clinic-selection': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Report?;
          return ClinicSelectionPage(report: args);
        }
      },
    );
  }
}