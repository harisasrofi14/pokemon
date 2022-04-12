import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/domain/entities/filters.dart';
import 'package:pokemon/presentation/bloc/filter/filter_bloc.dart';
import 'package:pokemon/presentation/bloc/filter/filter_event.dart';
import 'package:pokemon/presentation/bloc/filter/filter_state.dart';
import 'package:pokemon/presentation/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokemon/presentation/bloc/pokemon/pokemon_event.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  List<String> selected = [];
  List<Filters> _chipsList = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<FilterBloc>(context).add(OnGetFilters());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Filter",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    for (var chip in _chipsList) {
                      chip.isSelected = false;
                    }
                    BlocProvider.of<PokemonBloc>(context).page = 1;
                    BlocProvider.of<PokemonBloc>(context).isNeedClear = true;
                    BlocProvider.of<PokemonBloc>(context).add(const OnGetPokemon(""));
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Reset",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
              if (state is FilterLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FilterHasData) {
                _chipsList = state.result;
                return Wrap(
                  spacing: 8,
                  direction: Axis.horizontal,
                  children: typeChips(Colors.grey),
                );
              } else {
                return const Center(
                  child: Text("Empty"),
                );
              }
            }),
            ElevatedButton(
                onPressed: () {
                  for (var ch in _chipsList) {
                    if (ch.isSelected) {
                      selected.add(ch.filterTitle);
                    }
                  }
                  BlocProvider.of<PokemonBloc>(context).page = 1;
                  BlocProvider.of<PokemonBloc>(context).isNeedClear = true;
                  if (selected.isEmpty) {
                    BlocProvider.of<PokemonBloc>(context).add(const OnGetPokemon(""));
                  } else {
                    BlocProvider.of<PokemonBloc>(context)
                        .add(OnGetPokemon(selected.join('\',\'')));
                  }
                  Navigator.of(context).pop();
                },
                child: const Text("Filter"))
          ],
        ),
      ),
    ));
  }

  List<Widget> typeChips(color) {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: FilterChip(
          selectedColor: Colors.green,
          disabledColor: Colors.grey,
          label: Text(_chipsList[i].filterTitle),
          labelStyle: const TextStyle(color: Colors.white),
          backgroundColor: color,
          selected: _chipsList[i].isSelected,
          showCheckmark: false,
          checkmarkColor: Colors.white,
          onSelected: (bool value) {
            setState(() {
              _chipsList[i].isSelected = value;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}
