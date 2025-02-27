import 'package:chairy_e_commerce_app/features/product/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ProductEntity> cartItems;
  final num totalPrice;

  const CartLoaded({required this.cartItems, required this.totalPrice});

  @override
  List<Object> get props => [cartItems, totalPrice];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}
