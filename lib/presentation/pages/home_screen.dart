import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/domain/entities/pokemon.dart';
import 'package:pokemon/presentation/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokemon/presentation/bloc/pokemon/pokemon_event.dart';
import 'package:pokemon/presentation/bloc/pokemon/pokemon_state.dart';
import 'package:pokemon/presentation/widgets/card_pokemon.dart';
import 'package:pokemon/presentation/widgets/filter_sheet.dart';

class HomeScreen extends StatefulWidget {
  static const ROUTE_NAME = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLastPage = false;
  final scrollController = ScrollController();
  final List<Pokemon> _pokemon = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<PokemonBloc>(context).add(const OnGetPokemon(""));
    });
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      BlocProvider.of<PokemonBloc>(context).add(const OnGetPokemon(""));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokemon')),
      body: SafeArea(
        child:
            BlocBuilder<PokemonBloc, PokemonState>(builder: (context, state) {
          if (state is PokemonHasData) {
            if (BlocProvider.of<PokemonBloc>(context).isNeedClear) {
              _pokemon.clear();
            }
            _pokemon.addAll(state.result);
            BlocProvider.of<PokemonBloc>(context).isNeedClear = false;
            if (BlocProvider.of<PokemonBloc>(context).page > 1 &&
                state.result.isEmpty) {
              isLastPage = true;
            }
          } else if (state is PokemonError && _pokemon.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<PokemonBloc>(context)
                        .add(const OnGetPokemon(""));
                  },
                  icon: const Icon(Icons.refresh),
                ),
                const SizedBox(height: 15),
                Text(state.message, textAlign: TextAlign.center),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisExtent: 200,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: _pokemon.length + (isLastPage ? 1 : 0),
                controller: scrollController,
                itemBuilder: (context, index) {
                  if (index < _pokemon.length) {
                    return CardPokemon(_pokemon[index]);
                  } else {
                    return const Center(child: Text("No more to load"));
                  }
                }),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _settingModalBottomSheet(context);
        },
        child: const Icon(Icons.filter_list_outlined),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return const FilterSheet();
        });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
