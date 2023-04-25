part '../parts/invoice_payment_status.dart';

class InvoicePaymentStatus {
  String? code;
  String? name;
  String? color;

  InvoicePaymentStatus({
    this.color,
    this.code,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$InvoicePaymentStatusFromJson(json);
  factory InvoicePaymentStatus.fromJson(Map<String, dynamic> json) =>
      _$InvoicePaymentStatusFromJson(json);
  Map<String, dynamic> toJson() => _$InvoicePaymentStatusToJson(this);
}
