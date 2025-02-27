// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductImageModel _$ProductImageModelFromJson(Map<String, dynamic> json) =>
    ProductImageModel(
      id: (json['id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      link: json['link'] as String,
    );

Map<String, dynamic> _$ProductImageModelToJson(ProductImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'link': instance.link,
    };
