part '../parts/product_supp_penalty_types.dart';

class ProductSuppPenaltyTypes {
  String? code;
  String? name;

  ProductSuppPenaltyTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$ProductSuppPenaltyTypesFromJson(json);
  factory ProductSuppPenaltyTypes.fromJson(Map<String, dynamic> json) =>
      _$ProductSuppPenaltyTypesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductSuppPenaltyTypesToJson(this);
}
