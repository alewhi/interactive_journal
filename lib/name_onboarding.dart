import 'package:flutter/material.dart';
import 'avatar_onboarding.dart';

//onboarding page to get name
class NameOnboardingPage extends StatefulWidget {
  const NameOnboardingPage({super.key});

  @override
  State<NameOnboardingPage> createState() => _NameOnboardingPageState();
}

class _NameOnboardingPageState extends State<NameOnboardingPage> {
  final _nameController = TextEditingController(); //text input controller

  void _proceedToAvatar() {
    //validate and move to avatar page
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        //warning
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter your name')));
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AvatarOnboardingPage(userName: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF695E50),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Let’s start with a name',
                style: TextStyle(fontSize: 20, color: Color(0xFF4A4032)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Container(
                //input field
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF0),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: TextField(
                    controller: _nameController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF4A4032),
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Type your name here',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                //next button
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF695E50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  minimumSize: const Size(160, 48),
                  elevation: 2,
                ),
                onPressed: _proceedToAvatar,
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
