part '../parts/order_status.dart';

class OrderStatus {
  String? code;
  String? sentName;
  String? color;
  String? receivedName;

  OrderStatus({
    this.code,
    this.color,
    this.receivedName,
    this.sentName,
  });

  static $fromJson(Map<String, dynamic> json) => _$OrderStatusFromJson(json);
  factory OrderStatus.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStatusToJson(this);
}
