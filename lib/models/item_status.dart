part '../parts/item_status.dart';

class ItemStatus {
  String? code;
  String? name;

  ItemStatus({
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$ItemStatusFromJson(json);
  factory ItemStatus.fromJson(Map<String, dynamic> json) =>
      _$ItemStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ItemStatusToJson(this);
}
