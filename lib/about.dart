import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF2E0),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF695E50), size: 36),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Center(child: Image.asset('assets/app_logo.png', height: 100)),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'About ------',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF695E50),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '(...) is an interactive journaling app that helps you build mindful habits while growing your own peaceful garden. \n\nCheck in daily, nurture your plants, and discover your personal growth.',
                style: TextStyle(fontSize: 16, color: Color(0xFF4A4032)),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF0),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Credits',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF695E50),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Developed by Aleah White.\nBuilt with Flutter.',
                      style: TextStyle(color: Color(0xFF4A4032)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF0),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Version',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF695E50),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(color: Color(0xFF4A4032)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF0),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Contact',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF695E50),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'support@myjournalapp.com',
                      style: TextStyle(color: Color(0xFF4A4032)),
                    ),
                  ],
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
