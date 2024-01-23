part '../parts/product_buyer_penalty_types.dart';

class ProductBuyerPenaltyTypes {
  String? code;
  String? name;

  ProductBuyerPenaltyTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$ProductBuyerPenaltyTypesFromJson(json);
  factory ProductBuyerPenaltyTypes.fromJson(Map<String, dynamic> json) =>
      _$ProductBuyerPenaltyTypesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductBuyerPenaltyTypesToJson(this);
}
