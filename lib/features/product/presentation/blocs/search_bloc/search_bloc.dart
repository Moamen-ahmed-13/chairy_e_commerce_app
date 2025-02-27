import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chairy_e_commerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/product.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRepository productRepository;
  Timer? _debounceTimer;

  SearchBloc({required this.productRepository}) : super(SearchInitial()) {
    on<SearchTextChanged>(_onSearchTextChanged);
    on<RetrySearchEvent>((event, emit) {
      emit(SearchInitial());
    });
  }

  void _onSearchTextChanged(SearchTextChanged event, Emitter<SearchState> emit) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (event.query.isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());
      try {
        final products = await productRepository.searchProducts(event.query);
        if (products.isEmpty) {
          emit(SearchError("No products found"));
        } else {
          emit(SearchLoaded(products));
        }
      } catch (e) {
        emit(SearchError("Error searching products"));
      }
    });
  }
  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
