import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// second bit of onboarding to pick avatar
class AvatarOnboardingPage extends StatefulWidget {
  final String userName;
  final bool isChangingAvatar;

  AvatarOnboardingPage({
    super.key,
    required this.userName,
    this.isChangingAvatar = false, // add this
  });

  @override
  State<AvatarOnboardingPage> createState() => _AvatarOnboardingPageState();
}

class _AvatarOnboardingPageState extends State<AvatarOnboardingPage> {
  String selectedAvatar = 'assets/avatar1.png';

  //saves avatar and name in shared preferences
  Future<void> _completeProfile() async {
    final prefs = await SharedPreferences.getInstance();
    if (!widget.isChangingAvatar) {
      await prefs.setString('profileName', widget.userName);
    }
    await prefs.setString('profileAvatar', selectedAvatar);
    await prefs.setBool('hasProfile', true);

    if (widget.isChangingAvatar) {
      Navigator.pop(context, selectedAvatar); // return avatar to profile
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Widget _avatarOption(String path) {
    final isSelected = selectedAvatar == path;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAvatar = path;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? const Color(0xFF695E50) : Colors.transparent,
            width: 3,
          ),
        ),
        child: CircleAvatar(
          backgroundImage: AssetImage(path),
          radius: isSelected ? 42 : 35,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFCF2E0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF695E50)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                //choose avatar and shows chosen name
                'Choose your avatar, ${widget.userName}!',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF695E50),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _avatarOption('assets/avatar1.png'),
                  _avatarOption('assets/avatar2.png'),
                  _avatarOption('assets/avatar3.png'),
                  _avatarOption('assets/avatar4.png'),
                  _avatarOption('assets/avatar5.png'),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                //confirm button
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF695E50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _completeProfile,
                  child: const Text(
                    'Happy!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
