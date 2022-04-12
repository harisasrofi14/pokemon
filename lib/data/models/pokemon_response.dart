import 'dart:convert';

import 'package:pokemon/data/models/pokemon_model.dart';

PokemonResponse pokemonResponseFromJson(String str) =>
    PokemonResponse.fromJson(json.decode(str));

String pokemonResponseToJson(PokemonResponse data) =>
    json.encode(data.toJson());

class PokemonResponse {
  PokemonResponse({
    required this.data,
  });

  Data data;

  factory PokemonResponse.fromJson(Map<String, dynamic> json) =>
      PokemonResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.pokemons,
  });

  List<PokemonModel> pokemons;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pokemons: List<PokemonModel>.from(
            json["pokemons"].map((x) => PokemonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pokemons": List<dynamic>.from(pokemons.map((x) => x.toJson())),
      };
}
//
// class Attacks {
//   Attacks({
//     required this.fast,
//     required this.special,
//   });
//
//   List<Fast> fast;
//   List<Fast> special;
//
//   factory Attacks.fromJson(Map<String, dynamic> json) => Attacks(
//         fast: List<Fast>.from(json["fast"].map((x) => Fast.fromJson(x))),
//         special: List<Fast>.from(json["special"].map((x) => Fast.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "fast": List<dynamic>.from(fast.map((x) => x.toJson())),
//         "special": List<dynamic>.from(special.map((x) => x.toJson())),
//       };
// }
//
// class Fast {
//   Fast({
//     required this.name,
//     required this.type,
//     required this.damage,
//   });
//
//   String name;
//   String type;
//   int damage;
//
//   factory Fast.fromJson(Map<String, dynamic> json) => Fast(
//         name: json["name"],
//         type: json["type"],
//         damage: json["damage"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "type": type,
//         "damage": damage,
//       };
// }
//
// class Eight {
//   Eight({
//     required this.minimum,
//     required this.maximum,
//   });
//
//   String? minimum;
//   String? maximum;
//
//   factory Eight.fromJson(Map<String, dynamic> json) => Eight(
//         minimum: json["minimum"],
//         maximum: json["maximum"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "minimum": minimum,
//         "maximum": maximum,
//       };
// }
