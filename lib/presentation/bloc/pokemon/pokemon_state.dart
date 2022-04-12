import 'package:equatable/equatable.dart';
import 'package:pokemon/domain/entities/pokemon.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object?> get props => [];
}

class PokemonEmpty extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonError extends PokemonState {
  final String message;

  const PokemonError(this.message);

  @override
  List<Object> get props => [message];
}

class PokemonHasData extends PokemonState {
  final List<Pokemon> result;

  const PokemonHasData(this.result);

  @override
  List<Object> get props => [result];
}
