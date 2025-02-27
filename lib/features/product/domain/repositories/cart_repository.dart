import 'package:hive/hive.dart';
import 'package:chairy_e_commerce_app/features/product/domain/entities/product.dart';

class CartRepository {
  static const String cartBoxName = "cartBox";

  Future<Box<ProductEntity>> _openBox() async {
    return await Hive.openBox<ProductEntity>(cartBoxName);
  }

  Future<List<ProductEntity>> getCartItems() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> addToCart(ProductEntity product) async {
    final box = await _openBox();
    box.put(product.id, product);
  }

  Future<void> updateCart(List<ProductEntity> updatedCart) async {
    final box = await _openBox();
    await box.clear(); 
    for (var product in updatedCart) {
      box.put(product.id, product);
    }
  }

  Future<void> removeFromCart(ProductEntity product) async {
    final box = await _openBox();
    box.delete(product.id);
  }

  Future<void> clearCart() async {
    final box = await _openBox();
    await box.clear();
  }
}
