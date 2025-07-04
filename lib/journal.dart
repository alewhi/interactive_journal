import 'package:flutter/material.dart';
import 'package:interactive_journal/newentry.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:interactive_journal/journal_entry.dart';
import 'package:interactive_journal/mood_checkin_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

//journal page with entries, promts, forecats, new entry etc
class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

//detailed view of a journal entry
class JournalEntryDetail extends StatelessWidget {
  final JournalEntry entry;

  const JournalEntryDetail({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(entry.color),
      appBar: AppBar(
        backgroundColor: Color(entry.color),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF695E50)),
        title: Text(
          entry.title,
          style: const TextStyle(color: Color(0xFF695E50)),
        ),
        actions: [
          IconButton(
            //delete button
            icon: const Icon(Icons.delete),
            onPressed: () {
              entry.delete(); //delete from hive
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Entry deleted')));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF0),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                entry.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF695E50),
                ),
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF0),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Text(
                    entry.content,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4A4032),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              //edit button
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => NewEntryPage(
                          existingEntry: entry,
                          onSave: () => Navigator.pop(context),
                        ),
                  ),
                );
              },
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text('Edit', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF695E50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JournalPageState extends State<JournalPage> {
  String _searchQuery = ''; //current search

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
              const Text(
                'My Journal',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF695E50),
                ),
              ),
              const SizedBox(height: 20),

              GestureDetector(
                //new entry button
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder:
                          (_, __, ___) => NewEntryPage(
                            onSave: () {
                              Navigator.of(context).pop(); //close after save
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

              //mood and prompts buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.of(context).push<String>(
                          MaterialPageRoute(
                            builder: (_) => const MoodCheckInPage(),
                          ),
                        );

                        if (result != null) {
                          // update the shared preferences w new mood
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('windowImage', result);
                        }
                      },

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

              //saved entries
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Saved Entries',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF695E50),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: Color(0xFF695E50)),
                    onPressed: () {
                      //search
                      showDialog(
                        context: context,
                        builder: (context) {
                          final controller = TextEditingController();
                          return AlertDialog(
                            backgroundColor: const Color(0xFFFFFBF0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: const Text(
                              'Search Entries',
                              style: TextStyle(
                                color: Color(0xFF695E50),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                hintText: 'Type a word to search',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 16,
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Color(0xFF695E50)),
                                ),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF695E50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 24,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _searchQuery = controller.text.trim();
                                  });
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Search',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              //no entries fallback
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

                    //entries most recent first
                    final entries = box.values.toList().reversed.toList();

                    //apply search
                    final filteredEntries =
                        entries.where((entry) {
                          final query = _searchQuery.toLowerCase();
                          return entry.title.toLowerCase().contains(query);
                        }).toList();

                    if (filteredEntries.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'No matching entries.',
                              style: TextStyle(
                                color: Color(0xFF695E50),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Clear Search',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF695E50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredEntries.length,
                      itemBuilder: (context, index) {
                        final entry = filteredEntries[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFBF0),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    entry.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF695E50),
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${entry.date.day}/${entry.date.month}/${entry.date.year}",
                                    style: const TextStyle(
                                      color: Color(0xFF695E50),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => JournalEntryDetail(
                                              entry: entry,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                width: 12,
                                height: 60,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Color(entry.color),
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
