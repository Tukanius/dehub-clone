part '../parts/adjustment_status.dart';

class AdjustmentStatus {
  String? code;
  String? name;

  AdjustmentStatus({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$AdjustmentStatusFromJson(json);
  factory AdjustmentStatus.fromJson(Map<String, dynamic> json) =>
      _$AdjustmentStatusFromJson(json);
  Map<String, dynamic> toJson() => _$AdjustmentStatusToJson(this);
}
