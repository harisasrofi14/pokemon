import 'package:dartz/dartz.dart';
import 'package:pokemon/common/failure.dart';
import 'package:pokemon/domain/entities/filters.dart';
import 'package:pokemon/domain/entities/pokemon.dart';

abstract class IPokemonRepository {
  Future<Either<Failure, List<Pokemon>>> getPokemon(int page, String filter);

  Future<Either<Failure, List<Filters>>> getAllFilters();
}
