import 'package:pokemon/data/models/pokemon_table.dart';
import 'package:pokemon/data/models/types_table.dart';
import 'package:sqflite/sqflite.dart';

class PokemonDatabaseHelper {
  static PokemonDatabaseHelper? _databaseHelper;

  PokemonDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory PokemonDatabaseHelper() =>
      _databaseHelper ?? PokemonDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database = await _initDb();
    return _database;
  }

  static const String _tblPokemon = 'pokemon';
  static const String _tblTypes = 'types';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/poke.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblPokemon (
        id TEXT PRIMARY KEY,
        image TEXT,
        name TEXT,
        number TEXT,
        classification TEXT,
        fleeRate NUMBER,
        maxCP INTEGER,
        maxHP INTEGER
      );
      CREATE UNIQUE INDEX idx_pokemon
      ON pokemon (rowid);
    ''');

    await db.execute('''
      CREATE TABLE  $_tblTypes (
        id TEXT ,
        types TEXT
      );
    ''');
  }

  Future<int> insertPokemon(PokemonTable pokemonTable) async {
    final db = await database;
    return await db!.insert(_tblPokemon, pokemonTable.toJson());
  }

  Future<int> insertTypes(TypesTable typesTable) async {
    final db = await database;
    return await db!.insert(_tblTypes, typesTable.toJson());
  }

  Future<List<Map<String, dynamic>>> getAllPokemon() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblPokemon);
    return results;
  }

  Future<List<Map<String, dynamic>>> getPokemonRoles(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblTypes,
      where: 'id = ?',
      whereArgs: [id],
    );
    return results;
  }

  Future<List<Map<String, dynamic>>> getFilters() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.rawQuery("SELECT Types FROM $_tblTypes GROUP BY types");
    return results;
  }

  Future<List<Map<String, dynamic>>> getPokemonPagination(
      int page, String filter) async {
    int _perPage = 8;
    int limit = (page - 1) * 8;
    final db = await database;

    try {
      if (filter == '') {
        return await db!.rawQuery(
            "SELECT * FROM $_tblPokemon LIMIT $_perPage offset $limit");
      } else {
        return await db!.rawQuery(
            "SELECT A.* FROM $_tblPokemon A INNER JOIN $_tblTypes B ON A.id = B.id "
            "WHERE B.types IN ('$filter') GROUP BY A.name ORDER BY A.number LIMIT $_perPage offset $limit ");
      }
    } catch (e) {
      rethrow;
    }
    //return results;
  }
}
