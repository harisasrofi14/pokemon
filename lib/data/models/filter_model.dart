import 'package:equatable/equatable.dart';
import 'package:pokemon/domain/entities/filters.dart';

class PokemonFilter extends Equatable {
  final String filterTitle;

  const PokemonFilter(this.filterTitle);

  factory PokemonFilter.fromMap(Map<String, dynamic> map) {
    return PokemonFilter(map['types']);
  }

  Filters toEntity() {
    return Filters(filterTitle, false);
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
