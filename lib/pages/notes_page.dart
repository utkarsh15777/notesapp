import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp/components/drawer.dart';
import 'package:notesapp/components/note_tile.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/models/notes_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  @override
  void initState() {
    super.initState();

    readNote();
  }

  final textController = TextEditingController();

  void createNote(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: (){
              context.read<NoteDatabase>().addNotes(textController.text);
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              "Create Note"
            ),
          )
        ],
      ),
    );
  }

  void readNote(){
    context.read<NoteDatabase>().fetchNotes();
  }

  void updateNote(Note note,BuildContext context){
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          "Update Note"
        ),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: (){
              context.read<NoteDatabase>().updateNotes(note.id, textController.text);
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              "Update Note"
            ),
          )
        ],
      ),
    );
  }

  void deleteNote(Note note,BuildContext context){
    context.read<NoteDatabase>().deleteNotes(note.id);
  }

  @override
  Widget build(BuildContext context) {

    final noteDataBase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDataBase.currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: createNote,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Heading

          Padding(
            padding: const EdgeInsets.only(left: 25.0,top: 10.0),
            child: Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index){
                final note = currentNotes[index];
                return NoteTile(text: note.text, onEditPressed: () => updateNote(note,context) , onDeletePressed: () => deleteNote(note,context));
              },
            ),
          ),
        ],
      ),
    );
  }
}