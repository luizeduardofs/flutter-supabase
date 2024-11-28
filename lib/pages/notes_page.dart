import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth/auth_service.dart';
import 'upload_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();
  final authService = AuthService();

  Future<void> saveNote() async {
    await Supabase.instance.client
        .from('notes')
        .insert({'body': textController.text});
  }

  void addNewNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: textController),
        actions: [
          FilledButton(
            onPressed: () {
              saveNote();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  final _noteStream =
      Supabase.instance.client.from('notes').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    final currentEmail = authService.getCurrentUserEmail();

    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UploadPage(),
                      ),
                    );
                  },
                  child: const Text('Upload Page'))
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Notes'),
            Text(currentEmail ?? '', style: const TextStyle(fontSize: 16)),
          ],
        ),
        actions: [
          IconButton(
              onPressed: authService.signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: _noteStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final notes = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              final noteText = note['body'];
              return ListTile(title: Text(noteText));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
