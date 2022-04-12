import 'package:equatable/equatable.dart';

class TypesTable extends Equatable {
  final String id;
  final String types;

  const TypesTable({
    required this.id,
    required this.types,
  });

  factory TypesTable.fromEntity(String id, String type) {
    return TypesTable(id: id, types: type);
  }

  factory TypesTable.fromMap(Map<String, dynamic> map) =>
      TypesTable(id: map['id'], types: map['types']);

  Map<String, dynamic> toJson() => {'id': id, 'types': types};

  @override
  List<Object?> get props => [id, types];
}
