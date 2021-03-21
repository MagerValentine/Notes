class Note {
  String id;
  String createDate;
  String title;
  String text;
  String userId;

  Note({this.id, this.userId, this.title, this.text, this.createDate});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        text: json['text'],
        createDate: json['createDate']);
  }
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'text': text,
        'createDate': createDate
      };
}
