import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool remindersEnabled = true;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      remindersEnabled = prefs.getBool('remindersEnabled') ?? true;
    });
  }

  Future<void> toggleReminders(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('remindersEnabled', value);
    setState(() {
      remindersEnabled = value;
    });
  }

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('All data cleared')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF2E0),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF695E50), size: 36),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF695E50),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SwitchListTile(
                title: const Text(
                  'Daily Reminders',
                  style: TextStyle(color: Color(0xFF695E50)),
                ),
                value: remindersEnabled,
                onChanged: toggleReminders,
              ),
            ),

            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: const Icon(Icons.info, color: Color(0xFF695E50)),
                title: const Text(
                  'App Version',
                  style: TextStyle(color: Color(0xFF695E50)),
                ),
                subtitle: const Text(
                  '1.0.0',
                  style: TextStyle(color: Color(0xFF4A4032)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: const Icon(Icons.delete, color: Color(0xFF695E50)),
                title: const Text(
                  'Clear All Data',
                  style: TextStyle(color: Color(0xFF695E50)),
                ),
                onTap: clearData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
