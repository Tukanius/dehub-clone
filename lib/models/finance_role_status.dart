part '../parts/finance_role_status.dart';

class FinanceRoleStatus {
  String? code;
  String? name;
  String? color;

  FinanceRoleStatus({
    this.color,
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$FinanceRoleStatusFromJson(json);
  factory FinanceRoleStatus.fromJson(Map<String, dynamic> json) =>
      _$FinanceRoleStatusFromJson(json);
  Map<String, dynamic> toJson() => _$FinanceRoleStatusToJson(this);
}
