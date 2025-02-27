import 'package:equatable/equatable.dart';
import 'package:chairy_e_commerce_app/features/product/domain/entities/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final ProductEntity product;

  const AddToCartEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromCartEvent extends CartEvent {
  final ProductEntity product;

  const RemoveFromCartEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateCartQuantity extends CartEvent {
  final ProductEntity product;
  final int quantity;

  const UpdateCartQuantity(this.product, this.quantity);

  @override
  List<Object?> get props => [product, quantity];
}

class ClearCart extends CartEvent {}
