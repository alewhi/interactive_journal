import 'package:flutter/material.dart';
import 'package:interactive_journal/journal.dart';
import 'package:interactive_journal/newentry.dart';
import 'package:interactive_journal/garden.dart';
import 'package:interactive_journal/profile.dart';
import 'package:interactive_journal/hamburger_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'mood_checkin_page.dart';

//homepage
//decides if to show checkin today or not
Future<bool> shouldShowCheckIn() async {
  final prefs = await SharedPreferences.getInstance();
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final lastCheckInStr = prefs.getString('lastCheckIn');

  if (lastCheckInStr == today) return false;

  if (lastCheckInStr != null) {
    final lastCheckInDate = DateFormat('yyyy-MM-dd').parse(lastCheckInStr);
    final daysDifference = DateTime.now().difference(lastCheckInDate).inDays;

    if (daysDifference > 1) {
      // missed a day, reset streak
      await prefs.setInt('streak', 1);
    } else {
      // continue streak
      int streak = (prefs.getInt('streak') ?? 0) + 1;
      await prefs.setInt('streak', streak);
    }
  } else {
    // first check-in ever
    await prefs.setInt('streak', 1);
  }

  await prefs.setString('lastCheckIn', today);

  // grow plant on multiples of 5
  final streak = prefs.getInt('streak') ?? 0;
  if (streak % 5 == 0) {
    int stage = prefs.getInt('plantStage') ?? 0;
    stage++;
    await prefs.setInt('plantStage', stage);
  }

  return true;
}

Future<void> updatePlantStage() async {
  final prefs = await SharedPreferences.getInstance();
  final chosenPlant = prefs.getString('chosenPlant');
  if (chosenPlant == null) return;

  final streak = prefs.getInt('streak') ?? 0;

  //grows every 5 days
  final newStage = (streak ~/ 5).clamp(0, 3); // max stage 3
  await prefs.setInt('plantStage', newStage);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  String windowImage = 'assets/sunny_window.png'; //default weather

  final Map<String, List<String>> plantStages = {
    "flower": [
      "assets/flower_stage1.png",
      "assets/flower_stage2.png",
      "assets/flower_stage3.png",
      "assets/flower_stage4.png",
    ],
    "sunflower": [
      "assets/sunflower_stage1.png",
      "assets/sunflower_stage2.png",
      "assets/sunflower_stage3.png",
      "assets/sunflower_stage4.png",
    ],
  };

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

    //show mood checkin first
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final savedWindow = prefs.getString('windowImage');
      if (savedWindow != null) {
        setState(() {
          windowImage = 'assets/$savedWindow';
        });
      }
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
          await prefs.setString('windowImage', selectedImage);
          setState(() {
            windowImage = 'assets/$selectedImage';
          });
        }
      }

      final chosenPlant = prefs.getString('chosenPlant');
      if (chosenPlant == null) {
        await showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                backgroundColor: const Color(0xFFFFFBF0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  "Welcome!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF695E50),
                  ),
                ),
                content: const Text(
                  "Tap on the plant pot to choose your first plant.",
                  style: TextStyle(color: Color(0xFF695E50), fontSize: 16),
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF695E50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Perfect!"),
                  ),
                ],
              ),
        );
      }

      await updatePlantStage();
      setState(() {});
    });
  }

  void _handlePlantPotTapped() async {
    final prefs = await SharedPreferences.getInstance();
    final chosenPlant = prefs.getString('chosenPlant');

    if (chosenPlant == null) {
      //show plant chooser
      final plant = await showDialog<String>(
        context: context,
        builder:
            (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: const Color(0xFFFFFBF0),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Choose Your Starter Plant',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF695E50),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Image.asset(
                        'assets/flower_stage4.png',
                        height: 40,
                      ),
                      title: const Text(
                        'Petal Pip',
                        style: TextStyle(
                          color: Color(0xFF695E50),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () => Navigator.pop(context, 'flower'),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Image.asset(
                        'assets/sunflower_stage4.png',
                        height: 40,
                      ),
                      title: const Text(
                        'Sunny Bob',
                        style: TextStyle(
                          color: Color(0xFF695E50),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () => Navigator.pop(context, 'sunflower'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF695E50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      );

      if (plant != null) {
        await prefs.setString('chosenPlant', plant);
        await prefs.setInt('plantStage', 0); //start at stage 0 (sprout)
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF2E0),
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false, //disable default hamburger
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
        //show current page
        child:
            _selectedIndex == 0
                ? SingleChildScrollView(child: buildHomePageContent())
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
                        Navigator.of(context).pop();
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
            return;
          }

          if (i == 0) {
            //back to home. force window change
            final prefs = await SharedPreferences.getInstance();
            final savedWindow = prefs.getString('windowImage');
            if (savedWindow != null) {
              setState(() {
                windowImage = 'assets/$savedWindow';
              });
            }
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
        const SizedBox(height: 10),
        Padding(
          //show window with selected weather
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Image.asset(windowImage, fit: BoxFit.cover),
        ),
        const SizedBox(height: 40),

        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            // table floor
            Column(
              children: [
                Container(height: 55, color: const Color(0xFFcfc2ab)),
                Container(height: 20, color: const Color(0xFFb1a691)),
              ],
            ),

            // plant pot and flower
            Positioned(
              bottom: 35,
              child: GestureDetector(
                onTap: _handlePlantPotTapped,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // the pot
                    Image.asset('assets/plantpot.png', height: 265),

                    // the flower
                    FutureBuilder<SharedPreferences>(
                      future: SharedPreferences.getInstance(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox.shrink();
                        }
                        final prefs = snapshot.data!;
                        final chosenPlant = prefs.getString('chosenPlant');
                        final stage = prefs.getInt('plantStage') ?? 0;

                        if (chosenPlant == null) {
                          return const SizedBox.shrink();
                        }

                        final stages = plantStages[chosenPlant];
                        if (stages == null || stage >= stages.length) {
                          return const SizedBox.shrink();
                        }

                        return Image.asset(stages[stage], height: 265);
                      },
                    ),
                  ],
                ),
              ),
            ),

            //move to garden button
            FutureBuilder<SharedPreferences>(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox.shrink();
                final prefs = snapshot.data!;
                final chosenPlant = prefs.getString('chosenPlant');
                final stage = prefs.getInt('plantStage') ?? 0;

                if (chosenPlant == null) return const SizedBox.shrink();
                final stages = plantStages[chosenPlant];
                if (stages != null && stage == stages.length - 1) {
                  return Positioned(
                    bottom: 0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF695E50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        final garden = prefs.getStringList('garden') ?? [];
                        garden.add(chosenPlant);
                        await prefs.setStringList('garden', garden);
                        await prefs.remove('chosenPlant');
                        await prefs.setInt('plantStage', 0);
                        await prefs.setInt('streak', 0);
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Plant moved to garden!'),
                          ),
                        );
                      },
                      child: const Text(
                        'Move to Garden',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),

        const SizedBox(height: 24),
        Container(
          //streak box
          width: 220,
          margin: const EdgeInsets.symmetric(horizontal: 35),
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
              FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox();
                  final streak = snapshot.data!.getInt('streak') ?? 0;
                  return Text(
                    'Streak: $streak days',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF695E50),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(), //days eft until plant grows
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox();
            final streak = snapshot.data!.getInt('streak') ?? 0;
            final daysUntilNext =
                5 - (streak % 5); //calculate how many days left
            if (daysUntilNext == 0) return const SizedBox();
            return Text(
              '$daysUntilNext days until plant grows',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF695E50),
                fontWeight: FontWeight.w400,
              ),
            );
          },
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}
