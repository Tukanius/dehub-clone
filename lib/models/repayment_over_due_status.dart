part '../parts/repayment_over_due_status.dart';

class RepaymentOverDueStatus {
  String? code;
  String? name;
  String? color;

  RepaymentOverDueStatus({
    this.color,
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$RepaymentOverDueStatusFromJson(json);
  factory RepaymentOverDueStatus.fromJson(Map<String, dynamic> json) =>
      _$RepaymentOverDueStatusFromJson(json);
  Map<String, dynamic> toJson() => _$RepaymentOverDueStatusToJson(this);
}
