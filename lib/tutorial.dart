import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF2E0),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF695E50), size: 36),
        title: const Text(
          'Tutorial',
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
                  'How Things Work',
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• Each day you check in or make a journal entry, your streak goes up by 1.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4A4032),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• If you miss a day, your streak resets to day 1.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4A4032),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Every 5 days in a row, your plant grows one stage.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4A4032),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• When your plant reaches its final stage, you can move it to the garden and your streak will reset for the next plant.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4A4032),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Streaks are a fun way to build a daily journaling habit!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4A4032),
                        height: 1.5,
                      ),
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
