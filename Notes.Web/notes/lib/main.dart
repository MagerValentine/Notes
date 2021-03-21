import 'package:flutter/material.dart';
import 'package:notes/models/Note.dart';
import 'package:notes/models/httpService.dart';
import 'package:notes/widgets/addNoteForm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: NotesDashboard(title: 'Notes dashboard'),
      routes: {'/add': (context) => AddNewNote()},
    );
  }
}

class NotesDashboard extends StatefulWidget {
  NotesDashboard({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NotesDashboardState createState() => _NotesDashboardState();
}

class _NotesDashboardState extends State<NotesDashboard> {
  final HttpService httpService = new HttpService();

  Future<Note> futureNote;
  Future<List<Note>> futureNotes;

  @override
  void initState() {
    super.initState();
    futureNotes = _fetchNotes();
  }

  Future<bool> _deleteNote(String id) async {
    return httpService.deleteNote(id);
  }

  Future<List<Note>> _fetchNotes() async {
    return httpService.fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: futureNotes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              return CircularProgressIndicator.adaptive();
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Note note = snapshot.data[index];
                  return Dismissible(
                    // Show a red background as the item is swiped away.
                    background: Container(color: Colors.red),
                    key: Key(note.id),
                    onDismissed: (direction) {
                      _deleteNote(note.id);
                      setState(() {
                        snapshot.data.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("${note.title} deleted"),
                        duration: Duration(seconds: 1),
                      ));
                    },
                    child: Container(
                      key: Key(note.id),
                      height: 50,
                      color: Colors.green[index % 2 == 0 ? 200 : 400],
                      child: Center(
                          child: Text(
                        note.title,
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/add');
          setState(() {
            futureNotes = _fetchNotes();
          });
        },
        tooltip: 'Add new note',
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
