import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/booking_model.dart';

class DatabaseService {
  static Database? _database;
  static const String _dbName = 'sportnest.db';
  static const int _dbVersion = 1;

  // ─── Singleton ──────────────────────────────────────────────────────────────
  static final DatabaseService instance = DatabaseService._internal();
  DatabaseService._internal();

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  // ─── Init DB ────────────────────────────────────────────────────────────────
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    // Tabel users
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        namaLengkap TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        noTelepon TEXT NOT NULL,
        password TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    // Tabel bookings
    await db.execute('''
      CREATE TABLE bookings (
        id TEXT PRIMARY KEY,
        userId INTEGER NOT NULL,
        userEmail TEXT NOT NULL,
        lapanganId TEXT NOT NULL,
        lapanganNama TEXT NOT NULL,
        lapanganLokasi TEXT NOT NULL,
        lapanganImage TEXT NOT NULL,
        tanggal TEXT NOT NULL,
        jamMulai TEXT NOT NULL,
        jamSelesai TEXT NOT NULL,
        durasi INTEGER NOT NULL,
        totalHarga INTEGER NOT NULL,
        metodePembayaran TEXT NOT NULL,
        status TEXT NOT NULL,
        kodeBooking TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // USER CRUD
  // ═══════════════════════════════════════════════════════════════════════════

  /// Register user baru – kembalikan id jika berhasil, throw jika email sudah ada
  Future<int> registerUser({
    required String namaLengkap,
    required String email,
    required String noTelepon,
    required String password,
  }) async {
    final db = await database;

    // Cek duplikat email
    final existing = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (existing.isNotEmpty) {
      throw Exception('Email sudah terdaftar. Silakan gunakan email lain.');
    }

    final id = await db.insert('users', {
      'namaLengkap': namaLengkap,
      'email': email.toLowerCase(),
      'noTelepon': noTelepon,
      'password': password, // di produksi sebaiknya di-hash
      'createdAt': DateTime.now().toIso8601String(),
    });
    return id;
  }

  /// Login – kembalikan Map data user jika cocok, null jika tidak
  Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email.toLowerCase(), password],
    );
    if (result.isEmpty) return null;
    return result.first;
  }

  /// Ambil data user berdasarkan email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (result.isEmpty) return null;
    return result.first;
  }

  /// Ambil semua user (Untuk Admin)
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users', orderBy: 'createdAt DESC');
  }

  /// Update profil user
  Future<void> updateUser({
    required int userId,
    required String namaLengkap,
    required String noTelepon,
  }) async {
    final db = await database;
    await db.update(
      'users',
      {'namaLengkap': namaLengkap, 'noTelepon': noTelepon},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BOOKING CRUD
  // ═══════════════════════════════════════════════════════════════════════════

  /// Simpan booking baru
  Future<void> addBooking(BookingModel booking, int userId) async {
    final db = await database;
    await db.insert(
      'bookings',
      {
        'id': booking.id,
        'userId': userId,
        'userEmail': booking.userEmail,
        'lapanganId': booking.lapanganId,
        'lapanganNama': booking.lapanganNama,
        'lapanganLokasi': booking.lapanganLokasi,
        'lapanganImage': booking.lapanganImage,
        'tanggal': booking.tanggal.toIso8601String(),
        'jamMulai': booking.jamMulai,
        'jamSelesai': booking.jamSelesai,
        'durasi': booking.durasi,
        'totalHarga': booking.totalHarga,
        'metodePembayaran': booking.metodePembayaran,
        'status': booking.status,
        'kodeBooking': booking.kodeBooking,
        'createdAt': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Ambil semua booking milik user tertentu
  Future<List<BookingModel>> getBookingsByUserId(int userId) async {
    final db = await database;
    final result = await db.query(
      'bookings',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );
    return result.map((row) => BookingModel.fromJson({
          ...row,
          'tanggal': row['tanggal'],
        })).toList();
  }

  /// Update status booking (misal: Aktif → Selesai)
  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    final db = await database;
    await db.update(
      'bookings',
      {'status': newStatus},
      where: 'id = ?',
      whereArgs: [bookingId],
    );
  }

  /// Hapus booking
  Future<void> deleteBooking(String bookingId) async {
    final db = await database;
    await db.delete('bookings', where: 'id = ?', whereArgs: [bookingId]);
  }
}
