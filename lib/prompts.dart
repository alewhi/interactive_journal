import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PromptsPage extends StatelessWidget {
  const PromptsPage({super.key});

  final prompts = const [
    //Journal Prompts adapted from:
    //Reference: Wright. W. K. (2023), 550+ Journal Prompts: The Ultimate List, DayOne
    //Website: https://dayoneapp.com/blog/journal-prompts/
    "Write about a moment you’d love to relive.",
    "Briefly plan your week.",
    "What are my top priorities for the day?",
    "What worked well this week?",
    "What's one task I keep putting off and why?",
    "What is one new habit I would like to develop in the next month?",
    "Write about a place that has had a significant impact on your life, and what memories or emotions it brings up for you.",
    "What is the current problem or challenge I am facing? What are some potential solutions to this problem or challenge?",
    "What is one small act you believe can change the world?",
    "Write about a value you’ll never compromise.",
    "How do I get to use my creativity on a daily basis?",
    "What was a small detail I noticed today?",
    "Describe something you want to grow into.",
    "Describe the world 100 years from now.",
    "Write a letter to someone that you’ll never send.",
    "What are some things I want to remember about today?",
    "What do you cherish that others might overlook?",
    "Write about a quiet moment you’re grateful for.",
    "What advice would your future self give you?",
    "What could I have done differently today?",
    "Describe today from the perspective of a stranger.",
  ]; //end of adaptation.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF2E0),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF695E50)),
        title: const Text(
          'Prompts',
          style: TextStyle(
            color: Color(0xFF695E50),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: prompts.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFFFFFBF0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                prompts[index],
                style: const TextStyle(color: Color(0xFF4A4032), fontSize: 16),
              ),
              onTap: () {
                Clipboard.setData(ClipboardData(text: prompts[index]));
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Prompt copied!')));
              },
            ),
          );
        },
      ),
    );
  }
}
