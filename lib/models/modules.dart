part '../parts/modules.dart';

class Modules {
  String? code;
  String? name;

  Modules({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$ModulesFromJson(json);
  factory Modules.fromJson(Map<String, dynamic> json) =>
      _$ModulesFromJson(json);
  Map<String, dynamic> toJson() => _$ModulesToJson(this);
}
