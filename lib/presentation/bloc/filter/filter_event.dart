
abstract class FilterEvent {}


class SetFilter extends FilterEvent {
  final String type;
  SetFilter(this.type);
}

class OnGetFilters extends FilterEvent {

}