import 'package:flutter/material.dart';
import '../classes/notes.class.dart';

class NoteModel extends ChangeNotifier {
  List<Note> notes = [
    Note(1, 'Note A', 'Hello guys'),
    Note(2, 'Note B', 'This is a tutorial. This is a tutorial.'),
    Note(3, 'Note C', 'This is not a drill'),
    Note(4, 'Note D', 'Testing a note'),
    Note(5, 'Note E', 'What a beautiful day'),
    Note(6, 'Note F', "C'est la vie"),
    Note(7, 'Note G', "That's life"),
    Note(8, 'Note H', 'Running away is not the solution'),
  ];

  TextEditingController titleC = TextEditingController();
  TextEditingController contentC = TextEditingController();

  clearControllers() {
    titleC.text = '';
    contentC.text = '';
  }

  addNote(String title, String content) {
    // Get the biggest index
    int latestIdx = notes.map((e) => e.getId).reduce((value, element) {
      if (value > element) {
        return value;
      } else {
        return element + 0;
      }
    });

    notes.add(Note(latestIdx, title, content));
    clearControllers();

    notifyListeners();
  }

  saveNoteChanges(int id) {
    // Get a note that has the same id as modifiedNote's id
    int noteIdx = notes.indexWhere((element) => element.getId == id);

    notes[noteIdx] = Note(id, titleC.text, contentC.text);

    clearControllers();

    notifyListeners();
  }
}
