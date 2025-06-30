import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileOnboardingPage extends StatefulWidget {
  const ProfileOnboardingPage({super.key});

  @override
  State<ProfileOnboardingPage> createState() => _ProfileOnboardingPageState();
}

class _ProfileOnboardingPageState extends State<ProfileOnboardingPage> {
  final _nameController = TextEditingController();
  String selectedAvatar = 'assets/avatar1.png'; // default

  Future<void> _completeProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileName', _nameController.text.trim());
    await prefs.setString('profileAvatar', selectedAvatar);

    // FOR TESTING !! shows every hot restart:
    // do not save hasProfile true
    // await prefs.setBool('hasProfile', true),
    // navigate to homepage
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      appBar: AppBar(backgroundColor: const Color(0xFFFCF2E0), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF695E50),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'What should we call you?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose your avatar:',
              style: TextStyle(fontSize: 18, color: Color(0xFF695E50)),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap:
                      () =>
                          setState(() => selectedAvatar = 'assets/avatar1.png'),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar1.png'),
                    radius: selectedAvatar == 'assets/avatar1.png' ? 40 : 30,
                  ),
                ),
                GestureDetector(
                  onTap:
                      () =>
                          setState(() => selectedAvatar = 'assets/avatar2.png'),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar2.png'),
                    radius: selectedAvatar == 'assets/avatar2.png' ? 40 : 30,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF695E50),
              ),
              onPressed: _completeProfile,
              child: const Text(
                'Get Started',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
