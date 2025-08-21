import 'package:flutter/material.dart';
import 'router.dart';
import 'core/session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.instance.init();
  runApp(const VCareApp());
}

class VCareApp extends StatelessWidget {
  const VCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VCare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
      ),
      initialRoute: AppRouter.initialRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}

