import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'name_onboarding.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'journal_entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final hasProfile = prefs.getBool('hasProfile') ?? false;

  await Hive.initFlutter();
  Hive.registerAdapter(JournalEntryAdapter());
  await Hive.openBox<JournalEntry>('journalEntries');
  runApp(JournalApp(hasProfile: hasProfile));
}

class JournalApp extends StatelessWidget {
  final bool hasProfile;

  const JournalApp({super.key, required this.hasProfile});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: hasProfile ? const HomePage() : const NameOnboardingPage(),
      routes: {'/home': (context) => const HomePage()},
    );
  }
}
