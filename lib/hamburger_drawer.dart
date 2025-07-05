import 'package:flutter/material.dart';
import 'package:interactive_journal/homepage.dart';
import 'package:interactive_journal/about.dart';
import 'package:interactive_journal/settings.dart';
import 'package:interactive_journal/help.dart';
import 'package:interactive_journal/data_privacy.dart';

//hamburger menu
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFCF2E0),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            //banner at top of menu
            height: 160,
            decoration: const BoxDecoration(
              color: Color(0xFFBFAF90),
              image: DecorationImage(
                image: AssetImage('assets/menu_banner.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(16, 38, 16, 18),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 251, 247),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildDrawerItem(
            icon: Icons.home,
            label: 'Home',
            accentColor: const Color(0xFFA3B18A),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            label: 'Settings',
            accentColor: const Color(0xFFA3B18A),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          const Divider(color: Color(0xFF695E50), indent: 16, endIndent: 16),
          _buildDrawerItem(
            icon: Icons.info,
            label: 'About',
            accentColor: const Color(0xFFA3B18A),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.help_outline,
            label: 'Help',
            accentColor: const Color(0xFFA3B18A),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.security,
            label: 'Data & Privacy',
            accentColor: const Color(0xFFA3B18A),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DataPrivacyPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color accentColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        color: const Color(0xFFFFFBF0),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(icon, color: accentColor),
          title: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF4A4032),
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
