// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductEntityAdapter extends TypeAdapter<ProductEntity> {
  @override
  final int typeId = 0;

  @override
  ProductEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductEntity(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      discountPrice: fields[3] as String,
      quantity: fields[4] as int,
      information: '',
      price: '',
      productImages: [],
      bestSelling: 0,
      categories: [],
      colors: [],
      newArrival: 0,
      onSale: 0,
      discount: '',
      featuredProduct: 0,
      shippingReturn: '',
      sizes: [],
      sold: '',
      status: 0,
    );
  }

  @override
  void write(BinaryWriter writer, ProductEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.discountPrice)
      ..writeByte(4)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) =>
    ProductEntity(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      information: json['information'] as String?,
      shippingReturn: json['shippingReturn'] as String?,
      price: json['price'] as String,
      discount: json['discount'] as String,
      discountPrice: json['discount_Price'] as String,
      quantity: (json['quantity'] as num).toInt(),
      sold: json['sold'] as String,
      featuredProduct: (json['featured_Product'] as num).toInt(),
      bestSelling: (json['best_Selling'] as num).toInt(),
      newArrival: (json['new_Arrival'] as num).toInt(),
      onSale: (json['on_Sale'] as num).toInt(),
      status: (json['status'] as num).toInt(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      colors: (json['colors'] as List<dynamic>)
          .map((e) => ColorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sizes: (json['sizes'] as List<dynamic>)
          .map((e) => SizeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      productImages: (json['productimage'] as List<dynamic>)
          .map((e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductEntityToJson(ProductEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'information': instance.information,
      'shippingReturn': instance.shippingReturn,
      'price': instance.price,
      'discount': instance.discount,
      'discount_Price': instance.discountPrice,
      'quantity': instance.quantity,
      'sold': instance.sold,
      'featured_Product': instance.featuredProduct,
      'best_Selling': instance.bestSelling,
      'new_Arrival': instance.newArrival,
      'on_Sale': instance.onSale,
      'status': instance.status,
      'categories': instance.categories,
      'colors': instance.colors,
      'sizes': instance.sizes,
      'productimage': instance.productImages,
    };
