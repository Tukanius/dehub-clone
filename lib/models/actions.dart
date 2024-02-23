part '../parts/actions.dart';

class Actions {
  String? code;
  String? name;
  String? module;
  String? description;

  Actions({
    this.module,
    this.description,
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$ActionsFromJson(json);
  factory Actions.fromJson(Map<String, dynamic> json) =>
      _$ActionsFromJson(json);
  Map<String, dynamic> toJson() => _$ActionsToJson(this);
}
