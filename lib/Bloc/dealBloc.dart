import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dealsapp/Bloc/dealEvent.dart';
import 'package:dealsapp/Bloc/dealState.dart';
import 'package:dealsapp/models/Deals.dart';
import 'package:dealsapp/repository/dealRepository.dart';

class DealBloc extends Bloc<DealEvent, DealState> {
  final DealRepository repository;
  int _page = 1;
  final List<Deal> _deals = [];

  DealBloc(this.repository) : super(DealInitial()) {
    on<LoadDeals>(_onLoadDeals);
  }

  Future<void> _onLoadDeals(LoadDeals event, Emitter<DealState> emit) async {
    if (event.refresh) {
      _page = 1;
      _deals.clear();
    }

    emit(DealLoading());

    try {
      final newDeals = await repository.fetchDeals(event.endpoint, _page);

    
      _deals.addAll(newDeals);


      await repository.cacheDeals(event.endpoint, _deals);

      emit(DealLoaded(List.from(_deals), hasMore: newDeals.isNotEmpty));

      if (newDeals.isNotEmpty) _page++;
    } catch (e) {
      await _handleError(event, emit, e);
    }
  }

  Future<void> _handleError(
    LoadDeals event,
    Emitter<DealState> emit,
    Object e,
  ) async {
    final cached = await repository.loadCachedDeals(event.endpoint);
    if (cached.isNotEmpty) {
      emit(DealLoaded(cached, hasMore: false));
    } else {
      emit(DealError(e.toString()));
    }
  }
}
