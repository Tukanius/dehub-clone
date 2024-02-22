part '../parts/access_levels.dart';

class AccessLevels {
  String? code;
  String? name;

  AccessLevels({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$AccessLevelsFromJson(json);
  factory AccessLevels.fromJson(Map<String, dynamic> json) =>
      _$AccessLevelsFromJson(json);
  Map<String, dynamic> toJson() => _$AccessLevelsToJson(this);
}
