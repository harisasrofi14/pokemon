import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object?> get props => [];
}

class OnGetPokemon extends PokemonEvent {
  final String filter;

  const OnGetPokemon(this.filter);

  @override
  List<Object?> get props => [];
}
