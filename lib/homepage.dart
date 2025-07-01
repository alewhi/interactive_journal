import 'package:flutter/material.dart';
import 'package:interactive_journal/journal.dart';
import 'package:interactive_journal/newentry.dart';
import 'package:interactive_journal/garden.dart';
import 'package:interactive_journal/profile.dart';
import 'package:interactive_journal/hamburger_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'mood_checkin_page.dart';

Future<bool> shouldShowCheckIn() async {
  final prefs = await SharedPreferences.getInstance();
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final lastCheckIn = prefs.getString('lastCheckIn');

  // for testing!!:
  return true;

  if (lastCheckIn == today) return false;

  await prefs.setString('lastCheckIn', today);
  return true;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  String windowImage = 'assets/sunny_window.png'; // default weather

  @override
  void initState() {
    super.initState();
    _pages = [
      Container(), //placeholder
      const JournalPage(),
      NewEntryPage(
        onSave: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
      ),
      const GardenPage(),
      const ProfilePage(),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (await shouldShowCheckIn()) {
        final selectedImage = await Navigator.of(context).push<String>(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const MoodCheckInPage(),
            transitionsBuilder: (_, animation, __, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );

        if (selectedImage != null) {
          setState(() {
            windowImage = 'assets/$selectedImage';
          });
        }
      }
    });
  }

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
      body: SafeArea(
        child:
            _selectedIndex == 0
                ? buildHomePageContent()
                : _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFCF2E0),
        currentIndex: _selectedIndex,
        onTap: (i) async {
          if (i == 2) {
            final result = await Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder:
                    (_, __, ___) => NewEntryPage(
                      onSave: () {
                        Navigator.of(context).pop(); // close after save
                      },
                    ),
                transitionsBuilder: (_, animation, __, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
              ),
            );
            // dont change selected tab
            return;
          }
          setState(() => _selectedIndex = i);
        },

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

  Widget buildHomePageContent() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          DateFormat('MMMM d').format(DateTime.now()),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: 'sans-serif',
            color: Color(0xFF695E50),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Image.asset(windowImage, fit: BoxFit.cover),
        ),
        const SizedBox(height: 60),
        Column(
          children: [
            Container(height: 55, color: const Color(0xFFcfc2ab)),
            Container(height: 20, color: const Color(0xFFb1a691)),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          width: 200,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBF0),
            border: Border.all(color: const Color(0xFFE4D7BB), width: 1.5),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_fire_department, color: Color(0xFF695E50)),
              const SizedBox(width: 8),
              const Text(
                'Streak: 0 days',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF695E50),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
