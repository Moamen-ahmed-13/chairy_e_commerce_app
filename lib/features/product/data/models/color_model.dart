import 'package:json_annotation/json_annotation.dart';
part 'color_model.g.dart';
@JsonSerializable()
class ColorModel {
  final int id;
  final String name;
  final String code;

  ColorModel({
    required this.id,
    required this.name,
    required this.code,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) =>
      _$ColorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ColorModelToJson(this);
}
