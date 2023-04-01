// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../classes/notes.class.dart';
import '../components/note.widget.dart';
import '../providers/note.provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // String? username = FirebaseAuth.instance.currentUser?.displayName;
    String? username = 'Test';

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteModel>(create: (context) => NoteModel()),
      ],
      builder: (context, child) {
        NoteModel noteProvider = Provider.of<NoteModel>(context, listen: false);

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => {
                      // FirebaseAuth.instance.signOut()
                    },
                icon: const Icon(Icons.logout)),
            title: Text('Good Afternoon, $username!'),
            actions: [
              IconButton(
                  onPressed: () {
                    noteProvider.clearControllers();

                    showAddNoteDialog(context, noteProvider);
                  },
                  icon: const Icon(Icons.add))
            ],
            elevation: 2.3,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: LayoutBuilder(builder: (context, constraint) {
              int columnCount = (constraint.maxWidth / 200.0).floor();

              return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 32.0),
                  child: Consumer<NoteModel>(
                    builder: (context, noteProvider, child) {
                      List<Note> notes = noteProvider.notes;

                      return GridView.count(
                        crossAxisCount: columnCount,
                        clipBehavior: Clip.hardEdge,
                        mainAxisSpacing: 14.0,
                        crossAxisSpacing: 10.0,
                        children: List<Widget>.generate(notes.length,
                            (idx) => NoteWidget(notes[idx], noteProvider)),
                      );
                    },
                  ));
            }),
          ),
        );
      },
    );
  }
}

Future<void> showAddNoteDialog(BuildContext context, NoteModel nm) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          children: [
            TextField(controller: nm.titleC),
            TextField(controller: nm.contentC)
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Save'),
            onPressed: () {
              nm.addNote(nm.titleC.text, nm.contentC.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showEditNoteDialog(BuildContext context, NoteModel nm, int id) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          children: [
            TextField(controller: nm.titleC),
            TextField(
              controller: nm.contentC,
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Save'),
            onPressed: () {
              nm.saveNoteChanges(id);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
