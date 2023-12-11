part '../parts/product_supp_fee_rules.dart';

class ProductSuppFeeRules {
  String? code;
  String? name;

  ProductSuppFeeRules({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$ProductSuppFeeRulesFromJson(json);
  factory ProductSuppFeeRules.fromJson(Map<String, dynamic> json) =>
      _$ProductSuppFeeRulesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductSuppFeeRulesToJson(this);
}
