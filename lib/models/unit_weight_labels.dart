part '../parts/unit_weight_labels.dart';

class UnitWeightLabels {
  String? code;
  String? name;

  UnitWeightLabels({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$UnitWeightLabelsFromJson(json);
  factory UnitWeightLabels.fromJson(Map<String, dynamic> json) =>
      _$UnitWeightLabelsFromJson(json);
  Map<String, dynamic> toJson() => _$UnitWeightLabelsToJson(this);
}
