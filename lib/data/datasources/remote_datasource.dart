import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/util/gql_query.dart';

abstract class IRemoteDataSource {
  Future<List<PokemonModel>> getPokemon(int page);
}

class RemoteDataSource implements IRemoteDataSource {
  RemoteDataSource(this._client);

  final GraphQLClient _client;

  @override
  Future<List<PokemonModel>> getPokemon(int page) async {
    try {
      final result = await _client.query(QueryOptions(
          document: gql(GqlQuery.pokemonQuery), variables: {"page": page}));
      if (result.data == null) {
        return [];
      }
      return result.data?['pokemons']
          .map((e) => PokemonModel.fromJson(e))
          .cast<PokemonModel>()
          .toList();
    } on Exception {
      rethrow;
    }
  }
}
