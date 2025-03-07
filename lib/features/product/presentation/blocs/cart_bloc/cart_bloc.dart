import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chairy_e_commerce_app/features/product/domain/entities/cart_item.dart';
import 'package:chairy_e_commerce_app/features/product/domain/repositories/cart_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc(this.cartRepository) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartQuantity>(_onUpdateCartQuantity);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cartItems =
          await cartRepository.getCartItemsFromDB(); // Fetch from local DB
      final totalPrice =
          await cartRepository.getTotalPrice(); // Calculate total price
      emit(CartLoaded(cartItems: cartItems, totalPrice: totalPrice));
    } catch (e) {
      emit(CartError('Failed to load cart: $e'));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      final existingItem = currentState.cartItems.firstWhere(
          (item) => item.id == event.item.id,
          orElse: () => CartItem(id: '', title: '', price: 0, quantity: 0));

      if (existingItem.id.isEmpty) {
        final updatedCart = List<CartItem>.from(currentState.cartItems)
          ..add(event.item.copyWith(quantity: 1));

        await cartRepository.insertCartItem(event.item);

        final newTotalPrice = updatedCart.fold(
            0.0, (sum, item) => sum + (item.price * item.quantity));

        emit(CartLoaded(cartItems: updatedCart, totalPrice: newTotalPrice));
      } else {
        final updatedCart = currentState.cartItems.map((item) {
          if (item.id == event.item.id) {
            final updatedItem = item.copyWith(quantity: item.quantity + 1);
            cartRepository.updateCartItemQuantity(
                item.id, updatedItem.quantity);
            return updatedItem;
          }
          return item;
        }).toList();

        final newTotalPrice = updatedCart.fold(
            0.0, (sum, item) => sum + (item.price * item.quantity));

        emit(CartLoaded(cartItems: updatedCart, totalPrice: newTotalPrice));
      }
    }
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCart event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      final updatedCart =
          currentState.cartItems.where((item) => item.id != event.id).toList();
      await cartRepository.deleteCartItem(event.id);

      final newTotalPrice = updatedCart.fold(
          0.0, (sum, item) => sum + (item.price * item.quantity));
      emit(CartLoaded(cartItems: updatedCart, totalPrice: newTotalPrice));
    }
  }

  Future<void> _onUpdateCartQuantity(
      UpdateCartQuantity event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      final updatedCart = currentState.cartItems.map((item) {
        if (item.id == event.id) {
          final updatedItem =
              item.copyWith(quantity: event.quantity > 0 ? event.quantity : 1);
          cartRepository.updateCartItemQuantity(item.id, updatedItem.quantity);
          return updatedItem;
        }
        return item;
      }).toList();

      final newTotalPrice = updatedCart.fold(
          0.0, (sum, item) => sum + (item.price * item.quantity));

      emit(CartLoaded(cartItems: updatedCart, totalPrice: newTotalPrice));
    }
  }
}
