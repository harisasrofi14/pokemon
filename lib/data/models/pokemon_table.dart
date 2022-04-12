import 'package:equatable/equatable.dart';
import 'package:pokemon/data/models/pokemon_model.dart';

class PokemonTable extends Equatable {
  final String name;
  final String image;
  final String id;
  final String number;
  final String classification;
  final double fleeRate;
  final int maxCp;
  final int maxHp;

  const PokemonTable(
      {required this.id,
      required this.name,
      required this.image,
      required this.number,
      required this.classification,
      required this.fleeRate,
      required this.maxHp,
      required this.maxCp});

  factory PokemonTable.fromEntity(PokemonModel pokemonModel) {
    return PokemonTable(
        id: pokemonModel.id,
        name: pokemonModel.name,
        image: pokemonModel.image,
        number: pokemonModel.number,
        classification: pokemonModel.classification,
        fleeRate: pokemonModel.fleeRate,
        maxHp: pokemonModel.maxHp,
        maxCp: pokemonModel.maxCp);
  }

  factory PokemonTable.fromMap(Map<String, dynamic> map) => PokemonTable(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      number: map['number'],
      classification: map['classification'],
      fleeRate: map['fleeRate'],
      maxHp: map['maxHP'],
      maxCp: map['maxCP']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'number': number,
        'classification': classification,
        'fleeRate': fleeRate,
        'maxHP': maxHp,
        'maxCp': maxCp
      };

  @override
  List<Object?> get props =>
      [id, name, image, number, classification, fleeRate, maxHp, maxCp];
}
