import 'package:equatable/equatable.dart';
import 'package:chairy_e_commerce_app/features/product/domain/entities/cart_item.dart';

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;
  final double totalPrice;

  CartLoaded({required this.cartItems, required this.totalPrice});

  @override
  List<Object> get props => [cartItems, totalPrice];

  CartLoaded copyWith({List<CartItem>? cartItems, double? totalPrice}) {
    return CartLoaded(
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

class CartError extends CartState {
  final String message;

  CartError(this.message);

  @override
  List<Object> get props => [message];
}
