part of '../models/stats.dart';

Stats _$StatsFromJson(Map<String, dynamic> json) {
  return Stats(
    image: json['image'] != null ? json['image'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    amount:
        json['amount'] != null ? double.parse(json['amount'].toString()) : null,
    percent: json['percent'] != null
        ? double.parse(json['percent'].toString())
        : null,
    changedCount: json['changedCount'] != null
        ? double.parse(json['changedCount'].toString())
        : null,
    changedAmount: json['changedAmount'] != null
        ? double.parse(json['changedAmount'].toString())
        : null,
  );
}

Map<String, dynamic> _$StatsToJson(Stats instance) {
  Map<String, dynamic> json = {};

  if (instance.image != null) json['image'] = instance.image;
  if (instance.changedAmount != null) {
    json['changedAmount'] = instance.changedAmount;
  }
  if (instance.changedCount != null) {
    json['changedCount'] = instance.changedCount;
  }
  if (instance.percent != null) json['percent'] = instance.percent;
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
