import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF2E0),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF695E50), size: 36),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Need Help?',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF695E50),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'help goes here......',
              style: TextStyle(fontSize: 16, color: Color(0xFF4A4032)),
            ),
          ],
        ),
      ),
    );
  }
}
