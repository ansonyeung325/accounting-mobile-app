import 'package:bloc_project/model/keepbook.dart';
import 'package:bloc_project/providers/app_store.dart';
import 'package:bloc_project/providers/local_storage.dart';
import 'package:bloc_project/router/router.dart';
import 'package:bloc_project/utiles/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Get All KeepBooks
  final LocalStorage localStorage = LocalStorage();
  final Database? db = await localStorage.database;
  final AppStore appStore = AppStore();

  //Initialize appStore
  if (db != null) {
    List<KeepBook> keepBooks =
        await db.query('KeepBook').then((value) => value.map((e) => KeepBook.fromMap(e)).toList());
    localStorage.log(
        'getKeepBooks', 'List of KeepBook: ${keepBooks.map((e) => e.name).join(', ')}');
    appStore.keepBooks = keepBooks;
    if (keepBooks.isNotEmpty) {
      appStore.switchKeepBook = keepBooks.first;
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalStorage>(create: (_) => localStorage),
        ChangeNotifierProvider<AppStore>(create: (_) => appStore)
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
