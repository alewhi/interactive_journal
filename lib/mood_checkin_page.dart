import 'package:flutter/material.dart';

class MoodCheckInPage extends StatefulWidget {
  const MoodCheckInPage({super.key});

  @override
  State<MoodCheckInPage> createState() => _MoodCheckInPageState();
}

class _MoodCheckInPageState extends State<MoodCheckInPage> {
  String? selectedMood;

  final moods = {
    '☀️': 'sunny_window.png',
    '⛅': 'overcast_window.png',
    '🌧️': 'rainy_window.png',
    '🌙': 'night_window.png',
    '🌈': 'rainbow_window.png',
  };

  String currentWindowImage = 'sunny_window.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFCF2E0),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF695E50)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "What's today’s forecast?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF695E50),
              ),
            ),
            const SizedBox(height: 30),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Image.asset(
                'assets/$currentWindowImage',
                key: ValueKey(currentWindowImage),
                height: 320,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 40),
            //choose weather
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  moods.keys.map((mood) {
                    final isSelected = selectedMood == mood;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMood = mood;
                          currentWindowImage = moods[mood]!; // update preview
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                isSelected
                                    ? const Color(0xFF695E50)
                                    : Colors.grey,
                            width: 3,
                          ),
                          color: isSelected ? const Color(0xFFEADFC8) : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(mood, style: const TextStyle(fontSize: 24)),
                      ),
                    );
                  }).toList(),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF695E50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 16,
                ),
              ),
              onPressed:
                  selectedMood == null
                      ? null
                      : () {
                        Navigator.pop(context, currentWindowImage);
                      },
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
