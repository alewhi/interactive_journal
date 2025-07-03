import 'package:flutter/material.dart';

//shows garden with plants added
class GardenPage extends StatelessWidget {
  const GardenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              child: Text(
                'My Garden',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF695E50),
                ),
              ),
            ),

            // clouds background img
            Center(
              child: Image.asset(
                'assets/clouds.png',
                height: 230,
                fit: BoxFit.contain,
              ),
            ),

            // space for plants
            Expanded(
              child: Center(
                child: Text(
                  'Your plants will appear here',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
            ),

            Column(
              children: [Container(height: 210, color: Color(0xFFE4D7BB))],
            ),
          ],
        ),
      ),
    );
  }
}
