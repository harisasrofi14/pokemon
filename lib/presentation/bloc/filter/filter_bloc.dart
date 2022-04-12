import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/domain/entities/filters.dart';
import 'package:pokemon/domain/usecases/get_all_filters_usecase.dart';
import 'package:pokemon/presentation/bloc/filter/filter_event.dart';
import 'package:pokemon/presentation/bloc/filter/filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final GetAllFilters getAllFilters;

  FilterBloc({required this.getAllFilters}) : super(FilterEmpty()) {
    List<Filters> filters = [];
    on<OnGetFilters>((event, emit) async {
      emit((FilterLoading()));
      if (filters.isEmpty) {
        final result = await getAllFilters.execute();
        result.fold((failure) {
          emit(FilterError());
        }, (r) {
          filters.addAll(r);
          emit(FilterHasData(filters));
        });
      } else {
        emit(FilterHasData(filters));
      }
    });
    on<SetFilter>((event, emit) async {
      String type = event.type;
      final tile = filters.firstWhere((element) => element.filterTitle == type);
      tile.isSelected = !tile.isSelected;
    });
  }
}
