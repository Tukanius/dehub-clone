part '../parts/reference_types.dart';

class ReferenceTypes {
  String? code;
  String? name;

  ReferenceTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$ReferenceTypesFromJson(json);
  factory ReferenceTypes.fromJson(Map<String, dynamic> json) =>
      _$ReferenceTypesFromJson(json);
  Map<String, dynamic> toJson() => _$ReferenceTypesToJson(this);
}
