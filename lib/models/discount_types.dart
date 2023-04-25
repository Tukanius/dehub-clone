part '../parts/discount_types.dart';

class DiscountTypes {
  String? code;
  String? name;
  String? symbol;

  DiscountTypes({
    this.code,
    this.name,
    this.symbol,
  });

  static $fromJson(Map<String, dynamic> json) => _$DiscountTypesFromJson(json);
  factory DiscountTypes.fromJson(Map<String, dynamic> json) =>
      _$DiscountTypesFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountTypesToJson(this);
}
