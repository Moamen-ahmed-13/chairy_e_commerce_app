import 'package:json_annotation/json_annotation.dart';
part 'product_image_model.g.dart';
@JsonSerializable()
class ProductImageModel {
  final int id;
  @JsonKey(name: "product_id")
  final int productId;
  final String link;

 ProductImageModel({
    required this.id,
    required this.productId,
    required this.link,
  });    factory ProductImageModel.fromJson(Map<String, dynamic> json) => _$ProductImageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductImageModelToJson(this);
}