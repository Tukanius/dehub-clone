part of "../models/program_participant_status.dart";

ProgramParticipantStatus _$ProgramParticipantStatusFromJson(
    Map<String, dynamic> json) {
  return ProgramParticipantStatus(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    color: json['color'] != null ? json['color'] as String : null,
  );
}

Map<String, dynamic> _$ProgramParticipantStatusToJson(
    ProgramParticipantStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.color != null) json['color'] = instance.color;

  return json;
}
