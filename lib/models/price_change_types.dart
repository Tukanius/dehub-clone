part '../parts/price_change_types.dart';

class PriceChangeTypes {
  String? code;
  String? name;

  PriceChangeTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$PriceChangeTypesFromJson(json);
  factory PriceChangeTypes.fromJson(Map<String, dynamic> json) =>
      _$PriceChangeTypesFromJson(json);
  Map<String, dynamic> toJson() => _$PriceChangeTypesToJson(this);
}
