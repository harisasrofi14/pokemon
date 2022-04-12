import 'package:dartz/dartz.dart';
import 'package:pokemon/common/failure.dart';
import 'package:pokemon/domain/entities/filters.dart';
import 'package:pokemon/domain/repositories/pokemon_repository.dart';

class GetAllFilters {
  final IPokemonRepository repository;

  GetAllFilters(this.repository);

  Future<Either<Failure, List<Filters>>> execute() {
    return repository.getAllFilters();
  }
}
