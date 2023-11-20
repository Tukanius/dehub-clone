part '../parts/repayment_status.dart';

class RepaymentStatus {
  String? code;
  String? name;
  String? color;

  RepaymentStatus({
    this.color,
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$RepaymentStatusFromJson(json);
  factory RepaymentStatus.fromJson(Map<String, dynamic> json) =>
      _$RepaymentStatusFromJson(json);
  Map<String, dynamic> toJson() => _$RepaymentStatusToJson(this);
}
