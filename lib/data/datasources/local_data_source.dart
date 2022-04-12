import 'package:pokemon/common/exception.dart';
import 'package:pokemon/data/datasources/db/pokemon_database_helper.dart';
import 'package:pokemon/data/models/filter_model.dart';
import 'package:pokemon/data/models/pokemon_table.dart';
import 'package:pokemon/data/models/types_table.dart';

abstract class LocalDataSource {
  Future<String> insertPokemon(PokemonTable pokemonTable);

  Future<String> insertTypes(TypesTable types);

  Future<List<PokemonTable>> getAllPokemon();

  Future<List<PokemonFilter>> getFilters();

  Future<List<TypesTable>> getTypes(String id);

  Future<List<PokemonTable>> getPokemonPagination(int page, String filter);
}

class LocalDataSourceImpl implements LocalDataSource {
  final PokemonDatabaseHelper databaseHelper;

  LocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<PokemonTable>> getAllPokemon() async {
    try {
      final result = await databaseHelper.getAllPokemon();
      return result.map((data) => PokemonTable.fromMap(data)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<PokemonFilter>> getFilters() async {
    try {
      final result = await databaseHelper.getFilters();
      return result.map((data) => PokemonFilter.fromMap(data)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertPokemon(PokemonTable pokemonTable) async {
    try {
      await databaseHelper.insertPokemon(pokemonTable);
      return 'Success';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertTypes(TypesTable types) async {
    try {
      await databaseHelper.insertTypes(types);
      return 'Success';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TypesTable>> getTypes(String id) async {
    try {
      final result = await databaseHelper.getPokemonRoles(id);
      return result.map((data) => TypesTable.fromMap(data)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<PokemonTable>> getPokemonPagination(
      int page, String filter) async {
    try {
      final result = await databaseHelper.getPokemonPagination(page, filter);
      return result.map((data) => PokemonTable.fromMap(data)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
