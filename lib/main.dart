import 'dart:io';
import 'package:flashcard/data/database/database_helper.dart';
import 'package:flashcard/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize FFI for desktop platforms (SQLite doesn't work on web)

  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Initialize the database (triggers seed data on first run)
  await DatabaseHelper().database;

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()));
}
