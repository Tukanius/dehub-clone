part of '../models/qpay.dart';

Qpay _$QpayFromJson(Map<String, dynamic> json) {
  return Qpay(
    invoiceId: json['invoice_id'] != null ? json['invoice_id'] as String : null,
    qrText: json['qr_text'] != null ? json['qr_text'] as String : null,
    qrImage: json['qr_image'] != null ? json['qr_image'] as String : null,
    qPayShortUrl:
        json['qPay_shortUrl'] != null ? json['qPay_shortUrl'] as String : null,
    urls: json['urls'] != null
        ? (json['urls'] as List).map((e) => Urls.fromJson(e)).toList()
        : null,
    loanId: json['loanId'] != null ? json['loanId'] as String : null,
    loanPaybackGraphId: json['loanPaybackGraphId'] != null
        ? json['loanPaybackGraphId'] as String
        : null,
    amount:
        json['amount'] != null ? double.parse(json['amount'].toString()) : null,
    success: json['success'] != null
        ? Qpay.fromJson(json['success'] as Map<String, dynamic>)
        : null,
  );
}

Map<String, dynamic> _$QpayToJson(Qpay instance) {
  Map<String, dynamic> json = {};

  if (instance.success != null) json['success'] = instance.success;
  if (instance.loanId != null) json['loanId'] = instance.loanId;
  if (instance.loanPaybackGraphId != null)
    json['loanPaybackGraphId'] = instance.loanPaybackGraphId;
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.invoiceId != null) json['invoice_id'] = instance.invoiceId;
  if (instance.qrText != null) json['qr_text'] = instance.qrText;
  if (instance.qrImage != null) json['qr_image'] = instance.qrImage;
  if (instance.qPayShortUrl != null)
    json['qPay_shortUrl'] = instance.qPayShortUrl;

  return json;
}
