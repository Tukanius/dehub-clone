part '../parts/product_buyer_fee_rules.dart';

class ProductBuyerFeeRules {
  String? code;
  String? name;

  ProductBuyerFeeRules({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$ProductBuyerFeeRulesFromJson(json);
  factory ProductBuyerFeeRules.fromJson(Map<String, dynamic> json) =>
      _$ProductBuyerFeeRulesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductBuyerFeeRulesToJson(this);
}
