import 'package:equatable/equatable.dart';
import 'package:pokemon/domain/entities/pokemon.dart';

class PokemonModel extends Equatable {
  const PokemonModel(
      {required this.id,
      required this.number,
      required this.name,
      required this.classification,
      required this.fleeRate,
      required this.maxCp,
      required this.maxHp,
      required this.image,
      required this.types});

  final String id;
  final String number;
  final String name;
  final String classification;
  final double fleeRate;
  final int maxCp;
  final int maxHp;
  final String image;
  final List<String> types;

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
      id: json["id"],
      number: json["number"],
      name: json["name"],
      classification: json["classification"],
      fleeRate: json["fleeRate"].toDouble(),
      maxCp: json["maxCP"],
      maxHp: json["maxHP"],
      image: json["image"],
      types: List<String>.from(json["types"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "name": name,
        "classification": classification,
        "fleeRate": fleeRate,
        "maxCP": maxCp,
        "maxHP": maxHp,
        "image": image,
        "types": List<String>.from(types)
      };

  Pokemon toEntity() {
    return Pokemon(
        name: name,
        image: image,
        id: id,
        number: number,
        classification: classification,
        fleeRate: fleeRate,
        maxCp: maxCp,
        maxHp: maxHp,
        types: types);
  }

  @override
  List<Object?> get props => [];
}
