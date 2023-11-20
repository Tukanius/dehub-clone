part '../parts/stats.dart';

class Stats {
  String? image;
  String? name;
  double? amount;
  double? percent;

  Stats({
    this.percent,
    this.amount,
    this.image,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
  Map<String, dynamic> toJson() => _$StatsToJson(this);
}
