import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final double price;
  final double discountPrice;
  final String discount;
  int quantity; // لم يعد `final` لدعمه في السلة

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discount,
    required this.discountPrice,
    this.quantity = 1,
  });

  ProductEntity copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    double? discountPrice,
    String? discount,
    int? quantity,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      discount: discount ?? this.discount,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'discount_Price': discountPrice,
        'discount': discount,
        'quantity': quantity,
      };

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
        id: json['id'].toString(),
        title: json['title'] as String,
        description: json['description'] as String,
        price: (double.tryParse(json['price'].toString()) ?? 0.0).toDouble(),
        discountPrice:
            (double.tryParse(json['discount_Price'].toString()) ?? 0.0)
                .toDouble(),
        discount: json['discount'].toString(),
        quantity: json['quantity'] ?? 1,
      );

  @override
  List<Object?> get props =>
      [id, title, description, price, discountPrice, discount, quantity];
}
