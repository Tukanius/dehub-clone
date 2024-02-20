part '../parts/warehouse_status.dart';

class WarehouseStatus {
  String? code;
  String? name;

  WarehouseStatus({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$WarehouseStatusFromJson(json);
  factory WarehouseStatus.fromJson(Map<String, dynamic> json) =>
      _$WarehouseStatusFromJson(json);
  Map<String, dynamic> toJson() => _$WarehouseStatusToJson(this);
}
