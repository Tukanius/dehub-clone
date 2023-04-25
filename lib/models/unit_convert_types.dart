part '../parts/unit_convert_types.dart';

class UnitConvertTypes {
  String? code;
  String? name;

  UnitConvertTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$UnitConvertTypesFromJson(json);
  factory UnitConvertTypes.fromJson(Map<String, dynamic> json) =>
      _$UnitConvertTypesFromJson(json);
  Map<String, dynamic> toJson() => _$UnitConvertTypesToJson(this);
}
