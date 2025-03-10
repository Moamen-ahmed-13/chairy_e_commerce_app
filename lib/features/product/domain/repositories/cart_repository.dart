
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:chairy_e_commerce_app/features/product/domain/entities/cart_item.dart';

class CartRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE cart(id TEXT PRIMARY KEY, title TEXT, price REAL, quantity INTEGER)",
        );
      },
    );
  }

  Future<List<CartItem>> getCartItemsFromDB() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');
    return List.generate(maps.length, (i) {
      return CartItem(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        quantity: maps[i]['quantity'],

        
      );
    });
  }

  Future<void> insertCartItem(CartItem item) async {
    final db = await database;
    await db.insert(
      'cart',
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateCartItemQuantity(String id, int quantity) async {
    final db = await database;
    await db.update(
      'cart',
      {'quantity': quantity},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteCartItem(String id) async {
    final db = await database;
    await db.delete(
      'cart',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }

  Future<double> getTotalPrice() async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery("SELECT SUM(price * quantity) AS total FROM cart");
    return result.first["total"] ?? 0.0;
  }
}
