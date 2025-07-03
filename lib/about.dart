import 'package:flutter/material.dart';

//about screen w description, version and creds

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 242, 224, 1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF2E0),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF695E50), size: 36),
        title: const Text(
          'About',
          style: TextStyle(
            color: Color(0xFF695E50),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Center(child: Image.asset('assets/app_logo.png', height: 150)),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'About ------',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF695E50),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                //about desc stuff
                decoration: BoxDecoration(
                  color: Color(0xFFFFFBF0),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: const Text(
                  '[name] is a peaceful, interactive journaling experience designed to help you reflect on your thoughts, nurture your mental well-being, and grow over time. Each entry you make helps your personal garden flourish, blending mindful habits with fun.\n\n'
                  'Whether you’re writing about your day, tracking your mood, or simply capturing moments, [name] provides a safe, private space to explore your emotions and celebrate your growth.\n\n'
                  '• Private & Secure: All your journal entries are stored on your own device.\n'
                  '• No account needed: Focus on your personal journey without worrying about logins or social sharing.\n'
                  '• Grow your garden: Check in daily to see your virtual garden grow.\n'
                  '• Simple & calming design: Built to encourage peaceful, mindful reflection.\n\n'
                  'If you ever need help, visit the Help section or get in touch with us at (email)).',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4A4032),
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Container(
                //credits
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF0),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Credits',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF695E50),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Developed by Aleah White.\nBuilt with Flutter.',
                      style: TextStyle(color: Color(0xFF4A4032)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                //version
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF0),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Version',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF695E50),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(color: Color(0xFF4A4032)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                //contact
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF0),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Contact',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF695E50),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('email', style: TextStyle(color: Color(0xFF4A4032))),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
          Align(
            //footer image
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/about_footer.png',
              fit: BoxFit.cover,
              height: 80,
              width: 395,
            ),
          ),
        ],
      ),
    );
  }
}
