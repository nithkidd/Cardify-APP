import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final String fileName;
  final String key;

  // Path to your project's storage folder (for desktop development)
  static const String _storagePath =
      '/home/long/Desktop/cardify/Cardify-APP/lib/data/storage';

  StorageService({this.fileName = 'decks.json'})
    : key = fileName.replaceAll('.json', '_data');

  // Check if running on desktop (Linux/macOS/Windows)
  bool get _isDesktop =>
      !kIsWeb && (Platform.isLinux || Platform.isMacOS || Platform.isWindows);

  // ============ READ ============
  Future<String?> read() async {
    try {
      if (_isDesktop) {
        // Desktop: Read from project folder
        final file = File('$_storagePath/$fileName');
        if (!await file.exists()) return null;
        return await file.readAsString();
      } else {
        // Mobile/Web: Use SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString(key);
      }
    } catch (e) {
      throw Exception('Error reading data: $e');
    }
  }

  // ============ WRITE ============
  Future<void> write(String data) async {
    try {
      if (_isDesktop) {
        // Desktop: Write to project folder
        final file = File('$_storagePath/$fileName');
        await file.writeAsString(data);
      } else {
        // Mobile/Web: Use SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(key, data);
      }
    } catch (e) {
      throw Exception('Error writing data: $e');
    }
  }

  // ============ EXISTS ============
  Future<bool> exists() async {
    try {
      if (_isDesktop) {
        final file = File('$_storagePath/$fileName');
        return await file.exists();
      } else {
        final prefs = await SharedPreferences.getInstance();
        return prefs.containsKey(key);
      }
    } catch (e) {
      return false;
    }
  }

  // ============ DELETE ============
  Future<void> delete() async {
    try {
      if (_isDesktop) {
        final file = File('$_storagePath/$fileName');
        if (await file.exists()) {
          await file.delete();
        }
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(key);
      }
    } catch (e) {
      throw Exception('Error deleting data: $e');
    }
  }
}
