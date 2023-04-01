import 'package:flutter/material.dart';
import '../classes/notes.class.dart';
import '../pages/home.dart';
import '../providers/note.provider.dart';

class NoteWidget extends StatelessWidget {
  Note note = Note(0, 'title', 'content');
  NoteModel nm = NoteModel();

  NoteWidget(this.note, this.nm, {super.key});

  @override
  Widget build(BuildContext context) {
    const double standardRadius = 8.0;
    const BorderRadius noteRadius =
        BorderRadius.all(Radius.circular(standardRadius));
    const BorderRadius headerRadius = BorderRadius.only(
      topLeft: Radius.circular(standardRadius),
      topRight: Radius.circular(standardRadius),
    );

    return InkWell(
      onTap: () {
        nm.titleC.text = note.getTitle;
        nm.contentC.text = note.getContent;
        showEditNoteDialog(context, nm, note.getId);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 236, 180),
          borderRadius: noteRadius,
          boxShadow: [
            BoxShadow(
                offset: Offset(0.0, 3.0),
                blurRadius: 4.0,
                color: Color.fromRGBO(0, 0, 0, .2))
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: LayoutBuilder(
          builder: (context, constraint) => Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 238, 198, 78),
                  borderRadius: headerRadius,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      note.getTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: constraint.maxHeight - 35.0,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 16.0),
                    child: Text(note.getContent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
