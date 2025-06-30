import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final hasProfile = prefs.getBool('hasProfile') ?? false;

  runApp(JournalApp(hasProfile: hasProfile));
}

class JournalApp extends StatelessWidget {
  final bool hasProfile;

  const JournalApp({super.key, required this.hasProfile});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: hasProfile ? const HomePage() : const ProfileOnboardingPage(),
      routes: {'/home': (context) => const HomePage()},
    );
  }
}
