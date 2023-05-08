part '../parts/invitation_status.dart';

class InvitationStatus {
  String? code;
  String? name;
  String? receivedName;
  String? color;

  InvitationStatus({
    this.code,
    this.name,
    this.receivedName,
    this.color,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$InvitationStatusFromJson(json);
  factory InvitationStatus.fromJson(Map<String, dynamic> json) =>
      _$InvitationStatusFromJson(json);
  Map<String, dynamic> toJson() => _$InvitationStatusToJson(this);
}
