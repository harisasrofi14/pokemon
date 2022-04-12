import 'package:equatable/equatable.dart';

class Filters extends Equatable {
  String filterTitle;
  bool isSelected;

  Filters(this.filterTitle, this.isSelected);

  @override
  List<Object?> get props => [filterTitle, isSelected];
}
