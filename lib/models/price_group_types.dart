part '../parts/price_group_types.dart';

class PriceGroupTypes {
  String? code;
  String? name;

  PriceGroupTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$PriceGroupTypesFromJson(json);
  factory PriceGroupTypes.fromJson(Map<String, dynamic> json) =>
      _$PriceGroupTypesFromJson(json);
  Map<String, dynamic> toJson() => _$PriceGroupTypesToJson(this);
}
