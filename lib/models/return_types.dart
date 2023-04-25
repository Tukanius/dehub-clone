part '../parts/return_types.dart';

class ReturnTypes {
  String? code;
  String? name;

  ReturnTypes({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$ReturnTypesFromJson(json);
  factory ReturnTypes.fromJson(Map<String, dynamic> json) =>
      _$ReturnTypesFromJson(json);
  Map<String, dynamic> toJson() => _$ReturnTypesToJson(this);
}
