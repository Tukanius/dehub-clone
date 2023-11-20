part '../parts/request_status.dart';

class RequestStatus {
  String? code;
  String? name;
  String? color;

  RequestStatus({
    this.code,
    this.name,
    this.color,
  });

  static $fromJson(Map<String, dynamic> json) => _$RequestStatusFromJson(json);
  factory RequestStatus.fromJson(Map<String, dynamic> json) =>
      _$RequestStatusFromJson(json);
  Map<String, dynamic> toJson() => _$RequestStatusToJson(this);
}
