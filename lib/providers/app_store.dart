import 'package:bloc_project/model/keepbook.dart';
import 'package:flutter/material.dart';

class AppStore extends ChangeNotifier {
  List<KeepBook> keepBooks = [];

  KeepBook? currentKeepBook;

  set switchKeepBook(KeepBook keepBook) => currentKeepBook = keepBook;
}
