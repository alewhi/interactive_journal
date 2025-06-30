import 'package:flutter/material.dart';
import 'bug_report.dart';
import 'package:url_launcher/url_launcher.dart'; // for contact support

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
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text(
            'Help & Support',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF695E50),
            ),
          ),
          const SizedBox(height: 24),
          // contact box
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/help_boxes.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.email, color: Color(0xFF695E50)),
              title: const Text(
                'Contact Support',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF695E50),
                ),
              ),
              subtitle: const Text(
                'support@myjournalapp.com',
                style: TextStyle(color: Color(0xFF4A4032)),
              ),
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
          ),
          const SizedBox(height: 20),
          // report problem box
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/help_boxes.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.bug_report, color: Color(0xFF695E50)),
              title: const Text(
                'Report a Problem',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF695E50),
                ),
              ),
              subtitle: const Text(
                'Let us know if you spot a bug!',
                style: TextStyle(color: Color(0xFF4A4032)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BugReportPage()),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // terms/privacy box
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/help_boxes.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.privacy_tip, color: Color(0xFF695E50)),
              title: const Text(
                'Terms & Privacy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF695E50),
                ),
              ),
              subtitle: const Text(
                'Review our app policies',
                style: TextStyle(color: Color(0xFF4A4032)),
              ),
              onTap: () {},
            ),
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
          // FAQ accordion
          ExpansionTile(
            title: const Text(
              'How does mood tracking work?',
              style: TextStyle(color: Color(0xFF695E50)),
            ),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'add answer.............',
                  style: TextStyle(color: Color(0xFF4A4032)),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              'Can I recover journal entries?',
              style: TextStyle(color: Color(0xFF695E50)),
            ),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Currently there is no recovery, so please back up anything important manually.',
                  style: TextStyle(color: Color(0xFF4A4032)),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              'How do I grow plants?',
              style: TextStyle(color: Color(0xFF695E50)),
            ),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'When you check in with your mood and journal......',
                  style: TextStyle(color: Color(0xFF4A4032)),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              'Is my data safe?',
              style: TextStyle(color: Color(0xFF695E50)),
            ),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Your data is only saved on your device right now.',
                  style: TextStyle(color: Color(0xFF4A4032)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
