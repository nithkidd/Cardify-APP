import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database_seed.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _dbName = 'cardify.db';
  static const int _dbVersion = 1;

  // Singleton pattern
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: (db) async {
        // Enable foreign key constraints
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create decks table
    await db.execute('''
      CREATE TABLE decks (
        deckId TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        createdAt TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create flashcards table
    await db.execute('''
      CREATE TABLE flashcards (
        flashcardId TEXT PRIMARY KEY,
        deckId TEXT NOT NULL,
        frontText TEXT NOT NULL,
        backText TEXT NOT NULL,
        difficultyScore INTEGER DEFAULT 0,
        difficultyLevel TEXT DEFAULT 'easy',
        createdAt TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (deckId) REFERENCES decks (deckId) ON DELETE CASCADE

      )
    ''');

    await db.execute('''
  CREATE TABLE practice_sessions (
    sessionId TEXT PRIMARY KEY,
    deckId TEXT NOT NULL,
    title TEXT NOT NULL,
    sessionSize INTEGER,
    sessionType TEXT,
    createdAt TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (deckId) REFERENCES decks (deckId) ON DELETE CASCADE
  )
''');

    // Create index for faster queries
    await db.execute(
      'CREATE INDEX idx_flashcards_deckId ON flashcards (deckId)',
    );

    // Seed initial data
    await DatabaseSeed.seedData(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database migrations here
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
