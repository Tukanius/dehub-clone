part '../parts/price_end_types.dart';

class PriceEndTypes {
  String? code;
  String? name;

  PriceEndTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$PriceEndTypesFromJson(json);
  factory PriceEndTypes.fromJson(Map<String, dynamic> json) =>
      _$PriceEndTypesFromJson(json);
  Map<String, dynamic> toJson() => _$PriceEndTypesToJson(this);
}
