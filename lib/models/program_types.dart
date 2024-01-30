part '../parts/program_types.dart';

class ProgramTypes {
  String? code;
  String? name;

  ProgramTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$ProgramTypesFromJson(json);
  factory ProgramTypes.fromJson(Map<String, dynamic> json) =>
      _$ProgramTypesFromJson(json);
  Map<String, dynamic> toJson() => _$ProgramTypesToJson(this);
}
