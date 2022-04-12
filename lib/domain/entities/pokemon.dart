import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final String name;
  final String image;
  final String id;
  final String number;
  final String classification;
  final double fleeRate;
  final int maxCp;
  final int maxHp;
  final List<String> types;

  const Pokemon({
    required this.name,
    required this.image,
    required this.id,
    required this.number,
    required  this.classification,
    required this.fleeRate,
    required this.maxCp,
    required this.maxHp,
    required this.types});

  @override
  List<Object?> get props =>
      [name, image, id, number, classification, fleeRate, maxCp, maxHp];
}
