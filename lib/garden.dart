import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//shows garden with plants added
class GardenPage extends StatefulWidget {
  const GardenPage({super.key});

  @override
  State<GardenPage> createState() => _GardenPageState();
}

class _GardenPageState extends State<GardenPage> {
  List<String> _plants = [];
  late PageController _pageController;
  int _currentPage = 0;

  final Map<String, String> plantNicknames = {
    //change to nicknames w/out altering how plants are saved in prefs
    'flower': 'Petal Pip',
    'sunflower': 'Sunny Bob',
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    loadGarden();
  }

  Future<void> loadGarden() async {
    final prefs = await SharedPreferences.getInstance();
    final garden = prefs.getStringList('garden') ?? [];
    setState(() {
      _plants = garden;
      _currentPage = 0;
    });
  }

  void _goToPage(int index) {
    if (index >= 0 && index < _plants.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = index;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      body: SafeArea(
        child: Stack(
          children: [
            //clouds
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/clouds.png',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

            //floor
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 250,
              child: Container(color: const Color(0xFFE4D7BB)),
            ),

            Align(
              //displaying plants on floor
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 120,
                ), //how far plant is from floor
                child: SizedBox(
                  height: 400,
                  child:
                      _plants.isEmpty
                          ? Center(
                            child: Text(
                              'Your plants will appear here',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          )
                          : PageView.builder(
                            itemCount: _plants.length,
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset(
                                  'assets/${_plants[index]}_stage4.png',
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          ),
                ),
              ),
            ),

            //arrows + plant name
            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //left arrow
                  GestureDetector(
                    onTap:
                        _currentPage > 0
                            ? () => _goToPage(_currentPage - 1)
                            : null,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFF695E50),
                      child: Icon(
                        Icons.arrow_back,
                        color:
                            _currentPage > 0 ? Colors.white : Colors.grey[400],
                        size: 28,
                      ),
                    ),
                  ),

                  //current plant name
                  Text(
                    _plants.isNotEmpty
                        ? plantNicknames[_plants[_currentPage]] ??
                            _plants[_currentPage]
                        : '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF695E50),
                    ),
                  ),

                  //right arrow
                  GestureDetector(
                    onTap:
                        _currentPage < _plants.length - 1
                            ? () => _goToPage(_currentPage + 1)
                            : null,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFF695E50),
                      child: Icon(
                        Icons.arrow_forward,
                        color:
                            _currentPage < _plants.length - 1
                                ? Colors.white
                                : Colors.grey[400],
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //title
            const Positioned(
              top: 20,
              left: 24,
              child: Text(
                'My Garden',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF695E50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
