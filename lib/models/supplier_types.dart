part '../parts/supplier_types.dart';

class SupplierTypes {
  String? code;
  String? name;

  SupplierTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$SupplierTypesFromJson(json);
  factory SupplierTypes.fromJson(Map<String, dynamic> json) =>
      _$SupplierTypesFromJson(json);
  Map<String, dynamic> toJson() => _$SupplierTypesToJson(this);
}
