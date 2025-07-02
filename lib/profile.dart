import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Your Name';
  String avatar = 'assets/avatar_load.png';
  String dateJoined = '';
  int streak = 0;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('profileName') ?? 'Your Name';
      avatar = prefs.getString('profileAvatar')!;
      dateJoined =
          prefs.getString('dateJoined') ??
          DateFormat('MMMM d, y').format(DateTime.now());
      streak = prefs.getInt('streak') ?? 0;
    });
    if (!prefs.containsKey('dateJoined')) {
      prefs.setString(
        'dateJoined',
        DateFormat('MMMM d, y').format(DateTime.now()),
      );
    }
  }

  void _changeName() async {
    final newName = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: name);
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFBF0),
          title: const Text('Change your name'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter a new name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF695E50),
              ),
              onPressed: () {
                Navigator.pop(context, controller.text.trim());
              },
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    if (newName != null && newName.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileName', newName);
      setState(() {
        name = newName;
      });
    }
  }

  void _changeAvatar() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFBF0),
          title: const Text('Change your avatar'),
          content: const Text('This feature will be coming soon!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    if (confirm ?? false) {
      //change avatar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(backgroundImage: AssetImage(avatar), radius: 60),
              const SizedBox(height: 20),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF695E50),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Joined $dateJoined',
                style: const TextStyle(fontSize: 14, color: Color(0xFF4A4032)),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Current streak: $streak days',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF695E50),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF695E50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24,
                  ),
                ),
                onPressed: _changeName,
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  'Change Name',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF695E50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24,
                  ),
                ),
                onPressed: _changeAvatar,
                icon: const Icon(Icons.person, color: Colors.white),
                label: const Text(
                  'Change Avatar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'More profile features coming soon...',
                style: TextStyle(color: Color(0xFF4A4032)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
