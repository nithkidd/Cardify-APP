import 'dart:io';
import 'package:flashcard/data/database/database_service.dart';
import 'package:flashcard/ui/screens/deck_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize FFI for desktop platforms (SQLite doesn't work on web)
  if (!kIsWeb) {
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    // Initialize the database (triggers seed data on first run)
    await DatabaseService().database;
  }

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: DeckScreen()));
}
