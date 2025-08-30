
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toothy/views/auth/view/login_screen.dart';
import 'package:toothy/views/auth/view/register_screen.dart';
import 'package:toothy/views/onboarding/view/onboarding_view.dart';
import 'package:toothy/views/splashscreen/splashscreen_view.dart';

void main() {
  runApp(const MyApp());
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
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ),
    );
  }
}
