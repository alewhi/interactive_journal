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
        //dimmed background
        Opacity(
          opacity: 0.6,
          child: ModalBarrier(dismissible: false, color: Colors.black87),
        ),
        //popup content
        Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFFCF2E0),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //skip button
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: onSkip,
                    child: const Icon(Icons.close, color: Color(0xFF695E50)),
                  ),
                ),
                const SizedBox(height: 10),
                // Title
                const Text(
                  "How are you feeling today?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF695E50),
                  ),
                ),
                const SizedBox(height: 24),
                //mood options
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    for (var mood in ['😊', '😐', '😢', '😡', '😴'])
                      GestureDetector(
                        onTap: () => onMoodSelected(mood),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFFEADFC8),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            mood,
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
