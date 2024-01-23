part of "../models/invitation_status.dart";

InvitationStatus _$InvitationStatusFromJson(Map<String, dynamic> json) {
  return InvitationStatus(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    receivedName:
        json['receivedName'] != null ? json['receivedName'] as String : null,
    color: json['color'] != null ? json['color'] as String : null,
  );
}

Map<String, dynamic> _$InvitationStatusToJson(InvitationStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.color != null) json['color'] = instance.color;
  if (instance.receivedName != null) {
    json['receivedName'] = instance.receivedName;
  }

  return json;
}
