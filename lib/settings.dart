import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:interactive_journal/journal_entry.dart';

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

    final box = Hive.box<JournalEntry>('journalEntries');
    await box.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All app data and journal entries cleared')),
    );
  }

  void exportData() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Data exported (demo only)')));
  }

  void importData() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Data imported (demo only)')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF2E0),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF695E50), size: 36),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color(0xFF695E50),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            //reminders
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF0),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: SwitchListTile(
                activeColor: const Color(0xFF695E50),
                title: const Text(
                  'Daily Reminders',
                  style: TextStyle(
                    color: Color(0xFF695E50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: remindersEnabled,
                onChanged: toggleReminders,
              ),
            ),

            const SizedBox(height: 20),

            //version
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF0),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const ListTile(
                leading: Icon(Icons.info, color: Color(0xFF695E50)),
                title: Text(
                  'App Version',
                  style: TextStyle(
                    color: Color(0xFF695E50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  '1.0.0',
                  style: TextStyle(color: Color(0xFF4A4032)),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // clear data
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF0),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.delete_forever,
                  color: Color(0xFF695E50),
                ),
                title: const Text(
                  'Clear All Data',
                  style: TextStyle(
                    color: Color(0xFF695E50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: clearData,
              ),
            ),

            const SizedBox(height: 20),

            //export data
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF0),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.upload_file,
                  color: Color(0xFF695E50),
                ),
                title: const Text(
                  'Export Data',
                  style: TextStyle(
                    color: Color(0xFF695E50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: exportData,
              ),
            ),

            const SizedBox(height: 20),

            //import data
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF0),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(Icons.download, color: Color(0xFF695E50)),
                title: const Text(
                  'Import Data',
                  style: TextStyle(
                    color: Color(0xFF695E50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: importData,
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
