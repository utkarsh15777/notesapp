import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notesapp/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier{

  static late Isar isar;

  //initialize database
  static Future<void> initialize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar =  await Isar.open([NoteSchema], directory: dir.path);
  }

  //list of Notes
  final List<Note> currentNotes = [];


  //Create a note and save to db
  Future<void> addNotes(String textFromUser) async{

    //create a note
    final newNote = Note()..text = textFromUser;

    //Add to db
    await isar.writeTxn(() => isar.notes.put(newNote));

    //re-read from db
    await fetchNotes();

  }

  //Create a note and save it to db
  Future<void> fetchNotes() async{
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  //Update a note and save it to db
  Future<void> updateNotes(int id, String newNote) async{
    final noteFromDb = await isar.notes.get(id);
    if(noteFromDb!=null){
      noteFromDb.text = newNote;

      //Add to db
      await isar.writeTxn(() => isar.notes.put(noteFromDb));

      //re-read from db
      await fetchNotes();

    }
  }

  Future<void> deleteNotes(int id) async{
    await isar.writeTxn(() => isar.notes.delete(id));
    //re-read from db
    await fetchNotes();
  }

}