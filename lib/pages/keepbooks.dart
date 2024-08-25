import 'package:bloc_project/providers/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeepBooksPage extends StatelessWidget {
  KeepBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = Provider.of<LocalStorage>(context);

    return Center(
      child: Text(storage.dbname),
    );
  }
}
