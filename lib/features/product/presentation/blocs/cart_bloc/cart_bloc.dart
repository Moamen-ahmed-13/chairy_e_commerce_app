import 'package:chairy_e_commerce_app/features/product/domain/repositories/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../domain/entities/product.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  // late Box<ProductEntity> cartBox;
  final CartRepository cartRepository;

  CartBloc(this.cartRepository) : super(CartInitial()) {
    _initHive();
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _initHive() async {
    await Hive.openBox<ProductEntity>('cart');
    add(LoadCartEvent());
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
emit(CartLoading()); // Emit loading state
    try {
      final cartItems = await cartRepository.getCartItems();
      _calculateTotal(emit,cartItems);
      // emit(CartLoaded(cartItems: cartItems, totalPrice: total));
    } catch (e) {
      emit(CartError( "Failed to load cart: $e")); // Emit error state
    }  }

  Future<void> _onAddToCart(
      AddToCartEvent event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartLoaded) {
       try{
        await cartRepository.addToCart(event.product);
        final updatedCart = await cartRepository.getCartItems();
         _calculateTotal(emit,updatedCart);
        // emit(CartLoaded(cartItems: updatedCart, totalPrice: total));
      }catch(e){
        emit(CartError( "Failed to add to cart: $e"));
      }}
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartLoaded) {
     try{
        await cartRepository.removeFromCart(event.product);
        final updatedCart = await cartRepository.getCartItems();
         _calculateTotal(emit, updatedCart);
        // emit(CartLoaded(cartItems: updatedCart, totalPrice: total));
      }catch(e){
        emit(CartError( "Failed to remove from cart: $e"));
      }

    }
  }

  Future<void> _onUpdateQuantity(
      UpdateCartQuantity event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
       try{
        final updatedCart = currentState.cartItems.map((item) {
          if (item.id == event.product.id) {
            int newQuantity = item.quantity + event.quantity;
 if (newQuantity < 1) newQuantity = 1; // لا يمكن أن تكون الكمية أقل من 1
        return item.copyWith(quantity: newQuantity);          }
          return item;
        }).toList();

        await cartRepository.updateCart(updatedCart);
         _calculateTotal(emit, updatedCart);
        // emit(CartLoaded(cartItems: updatedCart, totalPrice: total));
      }catch(e){
        emit(CartError( "Failed to update quantity: $e"));
      }
    }
  }

//
  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
     try{
      await cartRepository.clearCart();
      emit(CartLoaded(cartItems: [], totalPrice: 0.0));
    }catch(e){
      emit(CartError( "Failed to clear cart: $e"));
    }
  }

  void _calculateTotal(Emitter<CartState> emit, List<ProductEntity> cartItems) {
  final totalPrice = cartItems.fold(
    0.0,
    (num sum, item) {
      // التحقق من أن `discountPrice` ليست null أو فارغة قبل التحويل
      final price = double.tryParse(item.discountPrice ?? '0.0') ?? 0.0;
      return sum + (price * item.quantity);
    },
  );

  emit(CartLoaded(cartItems: cartItems, totalPrice: totalPrice));
}
}
