part '../parts/program_status.dart';

class ProgramStatus {
  String? code;
  String? name;

  ProgramStatus({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$ProgramStatusFromJson(json);
  factory ProgramStatus.fromJson(Map<String, dynamic> json) =>
      _$ProgramStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ProgramStatusToJson(this);
}
