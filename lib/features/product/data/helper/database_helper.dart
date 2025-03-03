import 'package:path/path.dart';

import '../../domain/entities/cart_item.dart';
import 'package:sqflite/sqflite.dart';

class CartDbHelper {
    CartDbHelper._();
  static CartDbHelper db = CartDbHelper._();
  static Database? _database;



  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'cart_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart(
            id TEXT PRIMARY KEY,
            title TEXT,
            price REAL,
            quantity INTEGER
          )
        ''');
      },
    );
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart',where: 'quantity > 0');

    return List.generate(maps.length, (i) {
      return CartItem(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        quantity: maps[i]['quantity'],
      );
    });
  }

  Future<void> addToCart(CartItem item) async {
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
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> removeFromCart(String id) async {
    final db = await database;
    await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<double> getTotalPrice() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(price * quantity) AS total FROM cart');
    return result.first['total'] as double? ?? 0.0;
  }
}
