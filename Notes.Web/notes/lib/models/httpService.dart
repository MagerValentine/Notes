import 'package:notes/models/Note.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  final String _baseUrl = 'notesapi-dev.ap-south-1.elasticbeanstalk.com';

  Future<Note> fetchNote(String id) async {
    final response = await http.get(Uri.http(_baseUrl, '/api/note/$id'));
    if (response.statusCode == 200) {
      return Note.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load note');
    }
  }

  Future<bool> deleteNote(String id) async {
    final response = await http.delete(Uri.http(_baseUrl, '/api/note/$id'));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete note');
    }
  }

  Future<List<Note>> fetchNotes() async {
    final response = await http.get(Uri.http(_baseUrl, '/api/note'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Note.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load note');
    }
  }

  Future<bool> addNote(Note note) async {
    String body = jsonEncode(note);
    final response = await http.post(
      Uri.http(_baseUrl, 'api/note'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add note');
    }
  }
}
