part '../parts/program_participant_status.dart';

class ProgramParticipantStatus {
  String? code;
  String? name;
  String? color;

  ProgramParticipantStatus({
    this.code,
    this.name,
    this.color,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$ProgramParticipantStatusFromJson(json);
  factory ProgramParticipantStatus.fromJson(Map<String, dynamic> json) =>
      _$ProgramParticipantStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ProgramParticipantStatusToJson(this);
}
