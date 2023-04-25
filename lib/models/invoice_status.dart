part '../parts/invoice_status.dart';

class InvoiceStatus {
  String? code;
  String? name;
  String? color;

  InvoiceStatus({
    this.color,
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$InvoiceStatusFromJson(json);
  factory InvoiceStatus.fromJson(Map<String, dynamic> json) =>
      _$InvoiceStatusFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceStatusToJson(this);
}
