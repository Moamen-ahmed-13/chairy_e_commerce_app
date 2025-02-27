import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../data/models/category_model.dart';
import '../../data/models/color_model.dart';
import '../../data/models/product_image_model.dart';
import '../../data/models/size_model.dart';


part 'product.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class ProductEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  final String? information;
  final String? shippingReturn;

  final String price;
  final String discount;
  @JsonKey(name: "discount_Price")
  @HiveField(3)
  final String discountPrice;
  @HiveField(4)
   int quantity;
  final String sold;
  @JsonKey(name: "featured_Product")
  final int featuredProduct;
  @JsonKey(name: "best_Selling")
  final int bestSelling;
  @JsonKey(name: "new_Arrival")
  final int newArrival;
  @JsonKey(name: "on_Sale")
  final int onSale;
  final int status;
  final List<CategoryModel> categories;
  final List<ColorModel> colors;
  final List<SizeModel> sizes;
  @JsonKey(name: "productimage")
  final List<ProductImageModel> productImages;

   ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.information,
    required this.shippingReturn,
    required this.price,
    required this.discount,
    required this.discountPrice,
    required this.quantity,
    required this.sold,
    required this.featuredProduct,
    required this.bestSelling,
    required this.newArrival,
    required this.onSale,
    required this.status,
    required this.categories,
    required this.colors,
    required this.sizes,
    required this.productImages,
  });
ProductEntity copyWith({

    int? id,
    String? title,
    String? description,
    String? information,
    String? shippingReturn,
    double? price,
    double? discount,
    double? discountPrice,
    int? quantity,
    double? sold,
    int? featuredProduct,
    int? bestSelling,
    int? newArrival,
    int? onSale,
    int? status,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      information: information ?? this.information,
      shippingReturn: shippingReturn ?? this.shippingReturn,
      price: price.toString() ?? this.price,
      discount: discount.toString() ?? this.discount,
      discountPrice: discountPrice.toString() ?? this.discountPrice,
      quantity: quantity ?? this.quantity,
      sold: sold.toString() ?? this.sold,
      featuredProduct: featuredProduct ?? this.featuredProduct,
      bestSelling: bestSelling ?? this.bestSelling,
      newArrival: newArrival ?? this.newArrival,
      onSale: onSale ?? this.onSale,
      status: status ?? this.status, categories: [], colors: [], sizes: [], productImages: [],
    );
  }
  ///  تحويل JSON إلى كائن `ProductEntity`
  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);

  ///  تحويل `ProductEntity` إلى JSON
  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, title, description, price, discountPrice, quantity];
}
