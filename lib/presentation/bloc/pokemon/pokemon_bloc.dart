import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/domain/usecases/get_all_pokemon_usecase.dart';
import 'package:pokemon/presentation/bloc/pokemon/pokemon_event.dart';
import 'package:pokemon/presentation/bloc/pokemon/pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final GetAllPokemon getAllPokemon;
  int page = 1;
  bool isNeedClear = false;

  PokemonBloc({required this.getAllPokemon}) : super(PokemonEmpty()) {
    on<OnGetPokemon>((event, emit) async {
      emit(PokemonLoading());
      final result = await getAllPokemon.execute(page, event.filter);
      result.fold((failure) {
        emit(PokemonError(failure.message));
      }, (r) {
        emit(PokemonHasData(r));
        page++;
      });
    });
  }
}
