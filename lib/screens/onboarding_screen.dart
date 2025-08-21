import 'package:flutter/material.dart';
import '../core/session.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            const Icon(Icons.local_hospital, size: 96, color: Color(0xFF2E7D32)),
            const SizedBox(height: 16),
            const Text('Find and book top doctors', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Search, filter, and book appointments with trusted doctors near you.',
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await SessionManager.instance.setOnboarded();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: const Text('Get Started'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

