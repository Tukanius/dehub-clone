part '../parts/settlement_status.dart';

class SettlementStatus {
  String? code;
  String? name;

  SettlementStatus({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$SettlementStatusFromJson(json);
  factory SettlementStatus.fromJson(Map<String, dynamic> json) =>
      _$SettlementStatusFromJson(json);
  Map<String, dynamic> toJson() => _$SettlementStatusToJson(this);
}
