part '../parts/vat_types.dart';

class VatTypes {
  String? code;
  String? name;

  VatTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$VatTypesFromJson(json);
  factory VatTypes.fromJson(Map<String, dynamic> json) =>
      _$VatTypesFromJson(json);
  Map<String, dynamic> toJson() => _$VatTypesToJson(this);
}
