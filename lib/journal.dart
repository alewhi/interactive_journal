import 'package:flutter/material.dart';
import 'package:interactive_journal/newentry.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:interactive_journal/journal_entry.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              const Text(
                'My Journal',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF695E50),
                ),
              ),
              const SizedBox(height: 20),

              // new entry button
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
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
                            begin: const Offset(0, 1), // slide from bottom
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBF0),
                    borderRadius: BorderRadius.circular(16),
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
                    children: const [
                      Icon(Icons.add, color: Color(0xFF695E50)),
                      SizedBox(width: 8),
                      Text(
                        'New Entry',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF695E50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // mood and prompts buttons
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: AssetImage('assets/mood_box.png'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),

                      alignment: Alignment.center,
                      child: const Text(
                        'Forecast',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF695E50),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        //
                      },
                      child: Container(
                        height: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: AssetImage('assets/prompts_box.png'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Prompts',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF695E50),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // saved entries header
              const Text(
                'Saved Entries',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF695E50),
                ),
              ),

              const SizedBox(height: 16),

              // no entries fallback
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<JournalEntry>('journalEntries').listenable(),
                  builder: (context, Box<JournalEntry> box, _) {
                    if (box.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.book_outlined,
                              size: 50,
                              color: Color(0xFF695E50),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'No entries yet.\nTap "New Entry" to begin!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF695E50),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final reversedIndex = box.length - 1 - index;
                        final entry = box.getAt(reversedIndex);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFBF0),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // entry info
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    entry?.title ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF695E50),
                                    ),
                                  ),
                                  subtitle: Text(
                                    entry != null
                                        ? "${entry.date.day}/${entry.date.month}/${entry.date.year}"
                                        : '',
                                    style: const TextStyle(
                                      color: Color(0xFF695E50),
                                    ),
                                  ),
                                  onTap: () {
                                    // expand fully
                                  },
                                ),
                              ),
                              // colour tab
                              Container(
                                width: 12,
                                height: 60,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Color(entry?.color ?? 0xFFEADFC8),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
