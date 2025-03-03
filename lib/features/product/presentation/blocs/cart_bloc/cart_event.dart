
import 'package:chairy_e_commerce_app/features/product/domain/entities/cart_item.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final CartItem item;
  AddToCart(this.item);
}

class RemoveFromCart extends CartEvent {
  final String id;
  RemoveFromCart(this.id);
}

class UpdateCartQuantity extends CartEvent {
  final String id;
  final int quantity;
  UpdateCartQuantity(this.id, this.quantity);
}
