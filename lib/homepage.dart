import 'package:flutter/material.dart';
import 'package:interactive_journal/journal.dart';
import 'package:interactive_journal/newentry.dart';
import 'package:interactive_journal/garden.dart';
import 'package:interactive_journal/profile.dart';
import 'package:interactive_journal/hamburger_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _pages = const [
    HomePageContent(),
    JournalPage(),
    NewEntryPage(),
    GardenPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF2E0),
        elevation: 0,
        automaticallyImplyLeading: false, // disable default hamburger
        leading: Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 8.0),
          child: Builder(
            builder:
                (context) => IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 40,
                    color: Color(0xFF695E50),
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
          ),
        ),
      ),

      drawer: const AppDrawer(),
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFCF2E0),
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: const Color(0xFF6D5D4B),
        unselectedItemColor: Colors.grey[600],
        selectedIconTheme: const IconThemeData(size: 39),
        unselectedIconTheme: const IconThemeData(size: 35),
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Journal'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'Garden',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          'May 18',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: 'sans-serif',
            color: Color(0xFF695E50),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Image.asset('assets/rainy_window.png', fit: BoxFit.cover),
        ),

        const SizedBox(height: 60), //gap between window and shelf
        Column(
          children: [
            Container(height: 55, color: const Color(0xFFcfc2ab)),
            Container(height: 20, color: const Color(0xFFb1a691)),
          ],
        ),

        const SizedBox(height: 24), //gap between shelf and streak bit

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            color: Color(0xFFFFFBF0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Streak: 0 days',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'sans-serif',
              color: Color(0xFF695E50),
            ),
          ),
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}
