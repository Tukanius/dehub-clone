part '../parts/stock_movement_types.dart';

class StockMovementTypes {
  String? code;
  String? name;

  StockMovementTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$StockMovementTypesFromJson(json);
  factory StockMovementTypes.fromJson(Map<String, dynamic> json) =>
      _$StockMovementTypesFromJson(json);
  Map<String, dynamic> toJson() => _$StockMovementTypesToJson(this);
}
