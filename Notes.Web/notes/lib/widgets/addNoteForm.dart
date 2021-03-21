import 'package:flutter/material.dart';
import 'package:notes/models/Note.dart';
import 'package:notes/models/httpService.dart';
import 'package:uuid/uuid.dart';

class AddNewNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  final _noteTextController = new TextEditingController();
  final _titleTextController = new TextEditingController();
  final _httpService = new HttpService();
  final _uuid = new Uuid();

  Note _note = new Note();
  @override
  void initState() {
    super.initState();

    _noteTextController.addListener(() {
      _note.text = _noteTextController.text;
    });

    _titleTextController.addListener(() {
      _note.title = _titleTextController.text;
    });
  }

  @override
  void dispose() {
    super.dispose();

    _titleTextController.dispose();
    _noteTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add new note')),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(style: BorderStyle.solid))),
                    controller: _titleTextController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    decoration: InputDecoration(
                        labelText: "Note",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(style: BorderStyle.solid))),
                    controller: _noteTextController,
                  ),
                ),
                FloatingActionButton.extended(
                  onPressed: () async {
                    _note.createDate = DateTime.now().toIso8601String();
                    _note.id = _uuid.v4().toString();
                    _note.userId = 'ac86c4de-e5dc-4992-889e-4b33599c3b25';
                    bool result = await _httpService.addNote(_note);
                    if (result) Navigator.pop(context);
                  },
                  label: const Text('Save'),
                  icon: const Icon(Icons.save_alt),
                  // style: ButtonStyle(
                  //   backgroundColor:
                  //       MaterialStateProperty.all<Color>(Colors.green[600]),
                  // ),
                )
              ],
            )));
  }
}
