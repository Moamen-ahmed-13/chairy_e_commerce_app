// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../domain/usecases/get_products.dart';
// import 'product_event.dart';
// import 'product_state.dart';

// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final GetProductsUseCase _getProductsUseCase;

//   ProductBloc(this._getProductsUseCase) : super(ProductInitial()) {
//     on<LoadProductEvent>((event, emit) async {
//       emit(ProductLoading());
//       print("🚀 BLoC: Fetching products...");

//       final result =
//           await _getProductsUseCase.execute();
//       result.fold(
//         (failure) {
//           print("❌Bloc Error: ${failure.message}");
//           emit(ProductError(failure.message));
//         },
//         (products) {
//           print("✅Bloc Loaded Products: ${products.length} items");
//           emit(ProductLoaded(products));
//         },
//       );
//     });
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/product_model.dart';
import '../../../domain/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<SearchProductEvent>(_onSearchProducts);
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await repository.fetchProducts();
        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });
  }
  Future<void> _onSearchProducts(
      SearchProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await repository.searchProducts(event.query);
      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: 'Error searching products'));
    }
  }
}
