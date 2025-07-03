import 'package:flutter/material.dart';

//terms info page
class TermsPrivacyPage extends StatelessWidget {
  const TermsPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E8E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3E8E1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF695E50), size: 36),
        title: const Text(
          'Terms & Privacy',
          style: TextStyle(
            color: Color(0xFF695E50),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 10),
          Center(
            child: Icon(Icons.privacy_tip, size: 60, color: Color(0xFF695E50)),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Our Commitment to You',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF695E50),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF8),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: const Text(
              '''
This policy is for demonstration only.\n
Your data is stored only on your device and is never sent to any external servers. You are fully in control of your journal entries. Please remember to back up your data manually if you change or reset your device.
We do not collect, share, or sell any of your personal information.\n
By using this app, you agree to these terms and acknowledge you are responsible for your own data backups.
              ''',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF4A4032),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Text(
              'Thank you for your trust! 🌿',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Color(0xFF695E50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
