part '../parts/unit_space_labels.dart';

class UnitSpaceLabels {
  String? code;
  String? name;

  UnitSpaceLabels({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$UnitSpaceLabelsFromJson(json);
  factory UnitSpaceLabels.fromJson(Map<String, dynamic> json) =>
      _$UnitSpaceLabelsFromJson(json);
  Map<String, dynamic> toJson() => _$UnitSpaceLabelsToJson(this);
}
