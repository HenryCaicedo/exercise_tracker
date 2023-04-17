import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  static const _version = 2;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('user.db', _version);
    return _database!;
  }

  Future<Database> _initDB(String filepath, int version) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(
      path,
      version: version,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        username TEXT,
        email TEXT,
        password TEXT
      )
    ''');
    await db.execute('''
        CREATE TABLE recorridos (
          id INTEGER PRIMARY KEY,
          idUsuario INTEGER,
          distancia REAL,
          tipoActividad TEXT,
          tiempo INTEGER,
          puntos TEXT
        )
      ''');
    await db.execute('''
      CREATE TABLE segmentos (
        id INTEGER PRIMARY KEY,
        idUsuario INTEGER,
        privacidad INTEGER,
        nombre TEXT,
        tipoActividad TEXT,
        distancia REAL,
        tiempo TEXT,
        puntoInicio TEXT,
        puntoFinal TEXT,
        FOREIGN KEY (idUsuario) REFERENCES users(id)
      )
    ''');
  }

  Future<int> createSegment(
    int idUsuario,
    int privacidad,
    String nombre,
    String tipoActividad,
    double distancia,
    int tiempo,
    String puntoInicio,
    String puntoFinal,
  ) async {
    final db = await instance.database;

    return await db.insert('segmentos', {
      'idUsuario': idUsuario,
      'privacidad': privacidad,
      'nombre': nombre,
      'tipoActividad': tipoActividad,
      'distancia': distancia,
      'tiempo': tiempo,
      'puntoInicio': puntoInicio,
      'puntoFinal': puntoFinal,
    });
  }

  Future<int> createUser(
      {required String username,
      required String email,
      required String password}) async {
    final db = await instance.database;

    return await db.insert('users', {
      'username': username,
      'email': email,
      'password': password,
    });
  }

  Future<bool> userExists(String username, String password) async {
    final db = await instance.database;

    final result = await db.query('users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);

    return result.isNotEmpty;
  }

  Future<User?> getUserByUsername(String username) async {
    final db = await instance.database;

    final result =
        await db.query('users', where: 'username = ?', whereArgs: [username]);

    if (result.isNotEmpty) {
      final user = User.fromMap(result.first);
      return user;
    } else {
      return null;
    }
  }

  Future<int> getUserId(String username, String password) async {
    final db = await instance.database;

    final result = await db.rawQuery(
        'SELECT id FROM users WHERE username = ? AND password = ?',
        [username, password]);

    if (result.isNotEmpty) {
      return result.first['id'] as int;
    } else {
      return -1;
    }
  }

  Future<int> createRecorrido(int idUsuario, double distancia,
      String tipoActividad, int tiempo, List<LatLng> puntos) async {
    final db = await instance.database;

    final puntosString =
        puntos.map((p) => '${p.latitude},${p.longitude}').join(';');

    return await db.insert('recorridos', {
      'idUsuario': idUsuario,
      'distancia': distancia,
      'tipoActividad': tipoActividad,
      'tiempo': tiempo,
      'puntos': puntosString,
    });
  }
}

class User {
  final int id;
  final String username;
  final String email;
  final String password;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }
}
