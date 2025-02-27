import 'package:json_annotation/json_annotation.dart';
part 'size_model.g.dart';
@JsonSerializable()
class SizeModel{
   @JsonKey(name: "Size") // ✅ التأكد من أن `Size` تطابق JSON
  final String size;

  SizeModel({required this.size});
  factory SizeModel.fromJson(Map<String, dynamic> json) => _$SizeModelFromJson(json);
  Map<String, dynamic> toJson() => _$SizeModelToJson(this);


}