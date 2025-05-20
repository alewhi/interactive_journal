import 'package:flutter/material.dart';
import 'package:interactive_journal/homepage.dart';
import 'package:interactive_journal/about.dart';
import 'package:interactive_journal/settings.dart';
import 'package:interactive_journal/help.dart';

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
            height: 160,
            color: const Color(0xFFcfc2ab),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/menu_banner.png', fit: BoxFit.cover),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Hello!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 251, 246),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20), //adds a little gap above 'home' text

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text(
              'About',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.help),
            title: const Text(
              'Help',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
