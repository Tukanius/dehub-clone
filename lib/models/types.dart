part '../parts/types.dart';

class Types {
  String? code;
  String? name;

  Types({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$TypesFromJson(json);
  factory Types.fromJson(Map<String, dynamic> json) => _$TypesFromJson(json);
  Map<String, dynamic> toJson() => _$TypesToJson(this);
}
