import 'package:flutter/material.dart';
import 'package:interactive_journal/journal_entry.dart';
import 'package:interactive_journal/journal_data.dart';

class NewEntryPage extends StatefulWidget {
  final VoidCallback onSave;

  const NewEntryPage({super.key, required this.onSave});

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _saveEntry() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both a title and content')),
      );
      return;
    }

    final newEntry = JournalEntry(
      title: title,
      content: content,
      date: DateTime.now(),
    );

    journalEntries.add(newEntry);

    widget.onSave(); // trigger the tab switch
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF2E0),
        elevation: 0,
        title: const Text(
          'New Journal Entry',
          style: TextStyle(color: Color(0xFF695E50)),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF695E50)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Color(0xFF695E50)),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _contentController,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: 'Content',
                labelStyle: TextStyle(color: Color(0xFF695E50)),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF695E50),
              ),
              onPressed: _saveEntry,
              child: const Text(
                'Save Entry',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
