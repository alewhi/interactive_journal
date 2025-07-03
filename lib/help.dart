import 'package:flutter/material.dart';
import 'bug_report.dart';
import 'terms_privacy.dart';
import 'package:url_launcher/url_launcher.dart'; // for contact support

//help page w faqs
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

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
          'Help & Support',
          style: TextStyle(
            color: Color(0xFF695E50),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _helpCard(
            context,
            icon: Icons.email,
            title: 'Contact Support',
            subtitle: 'support@myjournalapp.com',
            onTap: () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'support@myjournalapp.com',
                query: 'subject=App Support Inquiry',
              );
              if (await canLaunchUrl(emailLaunchUri)) {
                await launchUrl(emailLaunchUri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Could not launch email app')),
                );
              }
            },
          ),
          const SizedBox(height: 16),
          _helpCard(
            context,
            icon: Icons.bug_report,
            title: 'Report a Problem',
            subtitle: 'Tell us if something went wrong',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BugReportPage()),
              );
            },
          ),
          const SizedBox(height: 16),
          _helpCard(
            context,
            icon: Icons.privacy_tip,
            title: 'Terms & Privacy',
            subtitle: 'Review our app policies',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TermsPrivacyPage()),
              );
            },
          ),
          const SizedBox(height: 30),
          const Text(
            'Frequently Asked',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF695E50),
            ),
          ),
          const SizedBox(height: 10),
          _styledExpansion(
            question: 'How do I create a new entry?',
            answer:
                'Tap the plus (+) button in the bottom navigation to start a new journal entry. You can add a title and write freely!',
          ),
          _styledExpansion(
            question: 'Where is my data stored?',
            answer:
                'All your journal entries are stored locally on your device and are never uploaded to a server.',
          ),
          _styledExpansion(
            question: 'Can I back up my journals?',
            answer:
                'Currently you will need to manually back up your data if you wish to transfer to a new device.',
          ),
          _styledExpansion(
            question: 'What is the garden feature for?',
            answer:
                'The garden grows and evolves based on your mood check-ins and journaling streaks, as a fun way to motivate daily reflection.',
          ),
          _styledExpansion(
            question: 'How do streaks work?',
            answer:
                'Each day you make an entry or check in with your weather forecast, your streak will increase by one. If you miss a day, your streak resets to zero. '
                'Keeping a consistent streak helps your virtual plant grow!',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  //reusable help card
  Widget _helpCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/help_boxes.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF695E50)),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF695E50),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Color(0xFF4A4032)),
        ),
        onTap: onTap,
      ),
    );
  }

  /// reusable accordion for FAQs
  Widget _styledExpansion({required String question, required String answer}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ExpansionTile(
        collapsedIconColor: const Color(0xFF695E50),
        iconColor: const Color(0xFF695E50),
        title: Text(
          question,
          style: const TextStyle(
            color: Color(0xFF695E50),
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              answer,
              style: const TextStyle(color: Color(0xFF4A4032)),
            ),
          ),
        ],
      ),
    );
  }
}
