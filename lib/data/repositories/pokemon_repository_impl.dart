import 'package:dartz/dartz.dart';
import 'package:pokemon/common/exception.dart';
import 'package:pokemon/common/failure.dart';
import 'package:pokemon/data/datasources/local_data_source.dart';
import 'package:pokemon/data/datasources/remote_datasource.dart';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/data/models/pokemon_table.dart';
import 'package:pokemon/data/models/types_table.dart';
import 'package:pokemon/domain/entities/filters.dart';
import 'package:pokemon/domain/entities/pokemon.dart';
import 'package:pokemon/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements IPokemonRepository {
  PokemonRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemon(
      int page, String filter) async {
    try {
      List<Pokemon> data = [];
      var localPokemon = await localDataSource.getAllPokemon();
      if (localPokemon.isEmpty) {
        final result = await remoteDataSource.getPokemon(100);
        await savePokemon(result);
      }
      localPokemon = await localDataSource.getPokemonPagination(page, filter);
      data = await parsingToPokemon(localPokemon);
      return Right(data);
    } on ServerException {
      return const Left(ServerFailure('Error'));
    }
  }

  Future<void> savePokemon(List<PokemonModel> pokemon) async {
    try {
      for (var value in pokemon) {
        var pokemon = PokemonTable.fromEntity(value);
        await localDataSource.insertPokemon(pokemon);
        for (var type in value.types) {
          var t = TypesTable.fromEntity(value.id, type);
          await localDataSource.insertTypes(t);
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Pokemon>> parsingToPokemon(localPokemon) async {
    List<Pokemon> pokemon = [];
    try {
      for (var poke in localPokemon) {
        List<TypesTable> types = await localDataSource.getTypes(poke.id);
        List<String> type = List<String>.from(types.map((x) => x.types));
        Pokemon p = Pokemon(
            id: poke.id,
            image: poke.image,
            name: poke.name,
            number: poke.number,
            classification: poke.classification,
            fleeRate: poke.fleeRate,
            maxCp: poke.maxCp,
            maxHp: poke.maxHp,
            types: type);
        pokemon.add(p);
      }

      return pokemon;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Filters>>> getAllFilters() async {
    try {
      var result = await localDataSource.getFilters();
      return Right(result.map((model) => model.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }
}
