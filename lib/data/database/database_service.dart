import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
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
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create decks table
    await db.execute('''
      CREATE TABLE decks (
        deckId TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        timesReviewed INTEGER DEFAULT 0,
        lastReviewed TEXT,
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
        correctCount INTEGER DEFAULT 0,
        incorrectCount INTEGER DEFAULT 0,
        difficultyLevel TEXT DEFAULT 'easy',
        createdAt TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (deckId) REFERENCES decks (deckId) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
  CREATE TABLE practice_sessions (
    sessionId TEXT PRIMARY KEY,
    deckId TEXT NOT NULL,
    sessionSize INTEGER,
    startTime TEXT,
    endTime TEXT,
    sessionType TEXT
  )
''');

    // Create index for faster queries
    await db.execute(
      'CREATE INDEX idx_flashcards_deckId ON flashcards (deckId)',
    );

    // Seed initial data
    await _seedData(db);
  }

  Future<void> _seedData(Database db) async {
    // Seed Spanish Vocabulary deck
    await db.insert('decks', {
      'deckId': '1',
      'name': 'Spanish Vocabulary',
      'category': 'general',
      'timesReviewed': 5,
      'lastReviewed': '2025-12-28',
    });
    await db.insert('flashcards', {
      'flashcardId': '1-1',
      'deckId': '1',
      'frontText': 'Hello',
      'backText': 'Hola',
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '1-2',
      'deckId': '1',
      'frontText': 'Goodbye',
      'backText': 'Adiós',
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '1-3',
      'deckId': '1',
      'frontText': 'Thank you',
      'backText': 'Gracias',
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '1-4',
      'deckId': '1',
      'frontText': 'Please',
      'backText': 'Por favor',
      'difficultyLevel': 'medium',
    });
    await db.insert('flashcards', {
      'flashcardId': '1-5',
      'deckId': '1',
      'frontText': 'Good morning',
      'backText': 'Buenos días',
      'difficultyLevel': 'medium',
    });

    // Seed Math Formulas deck
    await db.insert('decks', {
      'deckId': '2',
      'name': 'Math Formulas',
      'category': 'math',
      'timesReviewed': 3,
      'lastReviewed': '2025-12-27',
    });
    await db.insert('flashcards', {
      'flashcardId': '2-1',
      'deckId': '2',
      'frontText': 'Pythagorean theorem',
      'backText': 'a² + b² = c²',
      'difficultyLevel': 'medium',
    });
    await db.insert('flashcards', {
      'flashcardId': '2-2',
      'deckId': '2',
      'frontText': 'Area of a circle',
      'backText': 'A = πr²',
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '2-3',
      'deckId': '2',
      'frontText': 'Quadratic formula',
      'backText': 'x = (-b ± √(b²-4ac)) / 2a',
      'difficultyLevel': 'hard',
    });

    // Seed History Facts deck
    await db.insert('decks', {
      'deckId': '3',
      'name': 'History Facts',
      'category': 'history',
      'timesReviewed': 7,
      'lastReviewed': '2025-12-26',
    });
    await db.insert('flashcards', {
      'flashcardId': '3-1',
      'deckId': '3',
      'frontText': 'When did World War II end?',
      'backText': '1945',
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '3-2',
      'deckId': '3',
      'frontText': 'Who was the first president of the United States?',
      'backText': 'George Washington',
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '3-3',
      'deckId': '3',
      'frontText': 'What year did the French Revolution begin?',
      'backText': '1789',
      'difficultyLevel': 'medium',
    });
    await db.insert('flashcards', {
      'flashcardId': '3-4',
      'deckId': '3',
      'frontText': 'Who discovered America?',
      'backText': 'Christopher Columbus (1492)',
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '3-5',
      'deckId': '3',
      'frontText': 'What was the capital of the Roman Empire?',
      'backText': 'Rome',
      'difficultyLevel': 'easy',
    });
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
