// import 'package:json_annotation/json_annotation.dart';
// import '../../domain/entities/product.dart';
// import 'category_model.dart';
// import 'color_model.dart';
// import 'product_image_model.dart';
// import 'size_model.dart';

// part 'product_model.g.dart';

// @JsonSerializable()
// class ProductModel {
//   final int id;
//   final String title;
//   final String description;
//   final String? information;
//   final String? shippingReturn;
//   final double price;
//   final double discount;
//   @JsonKey(name: "discount_Price")
//   final double discountPrice;
//   final int quantity;
//   final double sold;
//   @JsonKey(name: "featured_Product")
//   final int featuredProduct;
//   @JsonKey(name: "best_Selling")
//   final int bestSelling;
//   @JsonKey(name: "new_Arrival")
//   final int newArrival;
//   @JsonKey(name: "on_Sale")
//   final int onSale;
//   final int status;
//   final List<CategoryModel> categories;
//   final List<ColorModel> colors;
//   final List<SizeModel> sizes;
//   @JsonKey(name: "productimage")
//   final List<ProductImageModel> productImages;

//   ProductModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.information,
//     required this.shippingReturn,
//     required this.price,
//     required this.discount,
//     required this.discountPrice,
//     required this.quantity,
//     required this.sold,
//     required this.featuredProduct,
//     required this.bestSelling,
//     required this.newArrival,
//     required this.onSale,
//     required this.status,
//     required this.categories,
//     required this.colors,
//     required this.sizes,
//     required this.productImages,
//   });

//   factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
//   Map<String, dynamic> toJson() => _$ProductModelToJson(this);

//   // ✅ تحويل `ProductModel` إلى `ProductEntity`
//   ProductEntity toEntity() {
//     return ProductEntity(
//       id: id,
//       title: title,
//       description: description,
//       information: information ?? "",
//       shippingReturn: shippingReturn ?? "",
//       price: price,
//       discount: discount,
//       discountPrice: discountPrice,
//       quantity: quantity,
//       sold: sold,
//       featuredProduct: featuredProduct,
//       bestSelling: bestSelling,
//       newArrival: newArrival,
//       onSale: onSale,
//       status: status,
//       categories: categories,
//       colors: colors,
//       sizes: sizes,
//       productImages: productImages,
//     );
//   }
// }
