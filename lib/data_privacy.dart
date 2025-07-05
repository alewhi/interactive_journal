import 'package:flutter/material.dart';

class DataPrivacyPage extends StatelessWidget {
  const DataPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 242, 224, 1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF2E0),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF695E50), size: 36),
        title: const Text(
          'Data & Privacy',
          style: TextStyle(
            color: Color(0xFF695E50),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'How Sprout Protects Your Data',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF695E50),
                  ),
                ),
              ),

              const SizedBox(height: 20),
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
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Sprout uses Hive to securely store your journals, mood check-ins, garden progress, and personal profile details right on your device. By keeping all your data local, Sprout guarantees that nothing is uploaded to a server or the cloud, ensuring your privacy and control. Hive is designed for fast, reliable performance on mobile, so your experience stays smooth even without an internet connection. This way, Sprout protects your personal reflections while giving you peace of mind.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4A4032),
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF0),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'If you have any questions about how your data is handled, please reach out to support@sprout.com.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4A4032),
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/about_footer.png',
              fit: BoxFit.cover,
              height: 80,
              width: 395,
            ),
          ),
        ],
      ),
    );
  }
}
