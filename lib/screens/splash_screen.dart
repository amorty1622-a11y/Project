import 'package:flutter/material.dart';
import '../core/session.dart';
import '../router.dart';
import 'onboarding_screen.dart';
import 'home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final onboarded = await SessionManager.instance.isOnboarded();
    final token = await SessionManager.instance.getToken();
    if (!mounted) return;
    if (!onboarded) {
      Navigator.of(context).pushReplacementNamed(OnboardingScreen.routeName);
    } else if (token == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

