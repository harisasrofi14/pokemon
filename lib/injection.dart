import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokemon/data/datasources/db/pokemon_database_helper.dart';
import 'package:pokemon/data/datasources/local_data_source.dart';
import 'package:pokemon/data/datasources/remote_datasource.dart';
import 'package:pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokemon/domain/usecases/get_all_filters_usecase.dart';
import 'package:pokemon/domain/usecases/get_all_pokemon_usecase.dart';
import 'package:pokemon/presentation/bloc/filter/filter_bloc.dart';
import 'package:pokemon/presentation/bloc/pokemon/pokemon_bloc.dart';

final locator = GetIt.instance;

void init() {
  final HttpLink link = HttpLink('https://graphql-pokemon2.vercel.app/');

  locator.registerFactory(() => PokemonBloc(getAllPokemon: locator()));
  locator.registerFactory(() => FilterBloc(getAllFilters: locator()));

  locator.registerLazySingleton(() => GetAllPokemon(locator()));
  locator.registerLazySingleton(() => GetAllFilters(locator()));

  locator.registerLazySingleton<IPokemonRepository>(() => PokemonRepositoryImpl(
      remoteDataSource: locator(), localDataSource: locator()));

  locator.registerLazySingleton<PokemonDatabaseHelper>(
      () => PokemonDatabaseHelper());

  locator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSource(
      GraphQLClient(
        cache: GraphQLCache(store: InMemoryStore()),
        link: link,
      ),
    ),
  );
}
