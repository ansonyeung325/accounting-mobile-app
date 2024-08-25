class KeepBook {
  int id;
  String name;

  KeepBook({required this.id, required this.name});

  factory KeepBook.fromMap(Map<String, dynamic> map) {
    return KeepBook(id: map['id'], name: map['name']);
  }
}
