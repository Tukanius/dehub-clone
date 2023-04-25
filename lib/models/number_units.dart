part '../parts/number_units.dart';

class NumberUnits {
  String? code;
  String? value;

  NumberUnits({
    this.code,
    this.value,
  });

  static $fromJson(Map<String, dynamic> json) => _$NumberUnitsFromJson(json);
  factory NumberUnits.fromJson(Map<String, dynamic> json) =>
      _$NumberUnitsFromJson(json);
  Map<String, dynamic> toJson() => _$NumberUnitsToJson(this);
}
