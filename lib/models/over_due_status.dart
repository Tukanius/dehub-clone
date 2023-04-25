part '../parts/over_due_status.dart';

class OverDueStatus {
  String? code;
  String? name;
  String? color;

  OverDueStatus({
    this.color,
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$OverDueStatusFromJson(json);
  factory OverDueStatus.fromJson(Map<String, dynamic> json) =>
      _$OverDueStatusFromJson(json);
  Map<String, dynamic> toJson() => _$OverDueStatusToJson(this);
}
