part '../parts/purchase_types.dart';

class PurchaseTypes {
  String? code;
  String? name;

  PurchaseTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$PurchaseTypesFromJson(json);
  factory PurchaseTypes.fromJson(Map<String, dynamic> json) =>
      _$PurchaseTypesFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseTypesToJson(this);
}
