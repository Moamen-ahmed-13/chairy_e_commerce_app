import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';
@JsonSerializable()
class CategoryModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final int status;

  CategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.status,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
  
}