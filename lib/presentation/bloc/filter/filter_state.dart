import 'package:equatable/equatable.dart';
import 'package:pokemon/domain/entities/filters.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object?> get props => [];
}

class FilterEmpty extends FilterState {}

class FilterLoading extends FilterState {}

class FilterHasData extends FilterState {
  final List<Filters> result;

  const FilterHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class FilterError extends FilterState {}
