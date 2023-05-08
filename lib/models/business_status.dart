part '../parts/business_status.dart';

class BusinessStatus {
  String? code;
  String? name;

  BusinessStatus({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$BusinessStatusFromJson(json);
  factory BusinessStatus.fromJson(Map<String, dynamic> json) =>
      _$BusinessStatusFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessStatusToJson(this);
}
