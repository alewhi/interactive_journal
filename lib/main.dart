import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'name_onboarding.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'journal_entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //get shared prefs to check if rofile exists
  final prefs = await SharedPreferences.getInstance();
  //wait prefs.clear(); //!!!!! for testing and demo - uncomment to reset whole app
  await prefs.remove(
    'lastCheckIn',
  ); //!!!!! for demo - uncomment for skip day, comment for real time
  final hasProfile = prefs.getBool('hasProfile') ?? false;
  print('DEBUG hasProfile = $hasProfile');

  await Hive.initFlutter(); //setup hive
  Hive.registerAdapter(JournalEntryAdapter());

  //final box = await Hive.openBox<JournalEntry>('journalEntries');
  //await box.clear(); // reset journal entries in hive for demo
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
      //if user has profile saved, go home otherwise show onboarding
      home: hasProfile ? const HomePage() : const NameOnboardingPage(),
      routes: {'/home': (context) => const HomePage()},
    );
  }
}
