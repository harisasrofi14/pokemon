import 'package:dartz/dartz.dart';
import 'package:pokemon/common/failure.dart';
import 'package:pokemon/domain/entities/pokemon.dart';
import 'package:pokemon/domain/repositories/pokemon_repository.dart';

class GetAllPokemon {
  final IPokemonRepository repository;

  GetAllPokemon(this.repository);

  Future<Either<Failure, List<Pokemon>>> execute(page, filter) {
    return repository.getPokemon(page, filter);
  }
}
