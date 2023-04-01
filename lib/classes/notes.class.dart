class Note {
  int _id = 0;
  String _title = '';
  String _content = '';

  set setId(int value) => _id = value;
  set setTitle(String value) => _title = value;
  set setContent(String value) => _content = value;

  int get getId => _id;
  String get getTitle => _title;
  String get getContent => _content;

  Note(int id, String title, String content) {
    _id = id;
    _title = title;
    _content = content;
  }

  @override
  String toString() {
    return '$_id, $_title, $_content';
  }
}
