import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SettlementInvoiceCard extends StatefulWidget {
  final Invoice data;
  const SettlementInvoiceCard({
    super.key,
    required this.data,
  });

  @override
  State<SettlementInvoiceCard> createState() => _SettlementInvoiceCardState();
}

class _SettlementInvoiceCardState extends State<SettlementInvoiceCard> {
  General general = General();

  overdueStatus() {
    final res = general.overdueStatus!.firstWhere(
        (element) => element.code == widget.data.invoice?.overdueStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).invoiceGeneral;
    return Container(
      padding: const EdgeInsets.all(10),
      color: white,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '#${widget.data.invoice?.refCode}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  '${Utils().formatCurrency(widget.data.invoice?.confirmedAmount.toString())}₮',
                  style: const TextStyle(color: invoiceColor),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Үлдсэн хоног: ${widget.data.invoice?.paymentDate?.difference(DateTime.now()).inDays}',
                  style: const TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Төлсөн: ${Utils().formatCurrency(widget.data.invoice?.paidAmount.toString())}₮',
                  style: const TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Үлдэгдэл: ${Utils().formatCurrency(widget.data.invoice?.amountToPay.toString())}₮',
                  style: const TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(int.parse(
                            overdueStatus().color.substring(1, 7),
                            radix: 16) +
                        0xff000000),
                  ),
                ),
                child: Text(
                  '${overdueStatus().name}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(int.parse(
                            overdueStatus().color.substring(1, 7),
                            radix: 16) +
                        0xff000000),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
