part '../parts/equity_types.dart';

class EquityTypes {
  String? code;
  String? name;

  EquityTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$EquityTypesFromJson(json);
  factory EquityTypes.fromJson(Map<String, dynamic> json) =>
      _$EquityTypesFromJson(json);
  Map<String, dynamic> toJson() => _$EquityTypesToJson(this);
}
