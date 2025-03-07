import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String id;
  final String title;
  final double price;
  late int quantity; // لم يعد `final` حتى يمكن تعديله مباشرةً

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      title: title,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'Quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json['id'],
        title: json['title'],
        price: (json['price'] as num).toDouble(),
        quantity: json['Quantity'],
      );

  @override
  List<Object?> get props => [id, title, price, quantity];
}
