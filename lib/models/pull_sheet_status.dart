part '../parts/pull_sheet_status.dart';

class PullSheetStatus {
  String? code;
  String? name;
  String? color;

  PullSheetStatus({
    this.code,
    this.name,
    this.color,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$PullSheetStatusFromJson(json);
  factory PullSheetStatus.fromJson(Map<String, dynamic> json) =>
      _$PullSheetStatusFromJson(json);
  Map<String, dynamic> toJson() => _$PullSheetStatusToJson(this);
}
