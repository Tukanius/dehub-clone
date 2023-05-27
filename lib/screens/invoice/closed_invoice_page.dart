import 'package:dehub/components/invoice_card/invoice_card.dart';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/invoice_empty/invoice_empty.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class ClosedInvoicePage extends StatefulWidget {
  static const routeName = 'ClosedInvoicePage';
  const ClosedInvoicePage({super.key});

  @override
  State<ClosedInvoicePage> createState() => _ClosedInvoicePageState();
}

class _ClosedInvoicePageState extends State<ClosedInvoicePage>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result invoice = Result(rows: [], count: 0);

  list(page, limit) async {
    Filter filter = Filter(
        // isReceived: true
        );
    Offset offset = Offset(page: page, limit: limit);
    Result res = await InvoiceApi().listClosed(
      ResultArguments(filter: filter, offset: offset),
    );
    setState(() {
      invoice = res;
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        iconTheme: IconThemeData(color: invoiceColor),
        title: Text(
          'Хаагдсан нэхэмжлэх',
          style: TextStyle(
            color: invoiceColor,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: SearchButton(
                color: invoiceColor,
              ),
            ),
            invoice.rows!.length != 0
                ? Column(
                    children: invoice.rows!
                        .map(
                          (e) => InvoiceCard(
                            data: e,
                          ),
                        )
                        .toList(),
                  )
                : InvoiceEmpty(),
          ],
        ),
      ),
    );
  }
}
