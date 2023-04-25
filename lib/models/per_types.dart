part '../parts/per_types.dart';

class PerTypes {
  String? code;
  String? name;

  PerTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$PerTypesFromJson(json);
  factory PerTypes.fromJson(Map<String, dynamic> json) =>
      _$PerTypesFromJson(json);
  Map<String, dynamic> toJson() => _$PerTypesToJson(this);
}
