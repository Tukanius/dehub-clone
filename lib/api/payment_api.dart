import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/http_request.dart';

class PaymentApi extends HttpRequest {
  Future<Invoice> qpay(Invoice data) async {
    var res = await post('/invoice', "PAYMENT", true,
        handler: true, data: data.toJson());
    return Invoice.fromJson(res as Map<String, dynamic>);
  }
}
