import 'package:flutter/material.dart';

class MoodCheckInPopup extends StatelessWidget {
  final Function(String mood) onMoodSelected;
  final VoidCallback onSkip;

  const MoodCheckInPopup({
    required this.onMoodSelected,
    required this.onSkip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.6,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFFCF2E0),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: onSkip,
                    child: const Icon(Icons.close, color: Color(0xFF695E50)),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "What's today’s forecast?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF695E50),
                  ),
                ),
                const SizedBox(height: 25),

                // Mood icon row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      ['☀️', '⛅', '🌧️', '🌩️'].map((mood) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => onMoodSelected(mood),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(0xFF695E50),
                                      width: 2,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    mood,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Icon(
                                Icons.circle,
                                size: 6,
                                color: Color(0xFF695E50),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),

                const SizedBox(height: 30),

                // "Submit" button
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFEADFC8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: onSkip, // Or submit
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Color(0xFF695E50),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                // Optional: torn bottom edge image can go here
              ],
            ),
          ),
        ),
      ],
    );
  }
}
