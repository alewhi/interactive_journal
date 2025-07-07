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
                  'About Sprout',
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
                child: const Text('''
Sprout is a calm yet powerful interactive journalling app that helps you capture notes, organise ideas, reflect on your thoughts, and build productive habits — all while watching your plants grow. Each streak nurtures your virtual garden, blending mindful reflection with fun motivation to keep you writing, thinking, and achieving your goals.

Whether you’re journalling about your day, making plans, setting intentions, or recording quick notes, Sprout turns your thoughts into growth.

• Private & Secure: All your journal entries are stored on your own device.
• No account needed: Focus on your personal journey without worrying about logins or social sharing.
• Grow your garden: Check in daily to see your virtual garden grow.
• Simple & calming design: Built to encourage peaceful, mindful reflection.

If you ever need help, visit the Help section or get in touch with us at support@sprout.com.
  ''', style: TextStyle(fontSize: 16, color: Color(0xFF4A4032), height: 1.5)),
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
                    Text(
                      'support@sprout.com',
                      style: TextStyle(color: Color(0xFF4A4032)),
                    ),
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
