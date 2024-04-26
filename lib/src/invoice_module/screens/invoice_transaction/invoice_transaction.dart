import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/invoice_module/components/invoice_transaction_card/history_card.dart';
import 'package:dehub/src/invoice_module/screens/transaction_detail/transaction_detail.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class InvoiceTransactionArguments {
  Invoice data;
  InvoiceTransactionArguments({
    required this.data,
  });
}

class InvoiceTransaction extends StatefulWidget {
  static const routeName = '/InvoiceTransaction';
  final Invoice data;
  const InvoiceTransaction({
    super.key,
    required this.data,
  });

  @override
  State<InvoiceTransaction> createState() => _InvoiceTransactionState();
}

class _InvoiceTransactionState extends State<InvoiceTransaction>
    with AfterLayoutMixin {
  Result invoice = Result();
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Invoice supplierBusiness = Invoice();
  Invoice buyerBusiness = Invoice();
  User user = User();

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(
        invoiceId: widget.data.senderBusiness != null
            ? widget.data.id
            : widget.data.invoiceId);
    invoice = await InvoiceApi()
        .settlementHistory(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    if (widget.data.receiverBusiness != null &&
        widget.data.senderBusiness != null) {
      supplierBusiness = widget.data.type == 'SALES'
          ? widget.data.senderBusiness!
          : widget.data.receiverBusiness!;
      buyerBusiness = widget.data.type == 'PURCHASE'
          ? widget.data.senderBusiness!
          : widget.data.receiverBusiness!;
    }
    await list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).invoiceMe;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        leading: const CustomBackButton(color: invoiceColor),
        leadingWidth: 130,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.data.senderBusiness != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Нэхэмжлэх',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/inv.svg',
                          colorFilter: const ColorFilter.mode(
                              invoiceColor, BlendMode.srcIn),
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(
                            '${widget.data.refCode}',
                            style: const TextStyle(color: invoiceColor),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: grey3,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Харилцагчийн код",
                    secondText: user.currentBusiness?.type == "SUPPLIER"
                        ? buyerBusiness.refCode
                        : supplierBusiness.refCode,
                    secondTextColor: invoiceColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: user.currentBusiness?.type == "SUPPLIER"
                        ? "Худалдан авагч"
                        : "Нийлүүлэгч",
                    secondText: user.currentBusiness?.type == "SUPPLIER"
                        ? buyerBusiness.profileName
                        : supplierBusiness.profileName,
                    secondTextColor: invoiceColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Партнер нэр",
                    secondText: user.currentBusiness?.type == "SUPPLIER"
                        ? "${buyerBusiness.partner?.refCode}, ${buyerBusiness.partner?.businessName}"
                        : "${supplierBusiness.partner?.refCode}, ${supplierBusiness.partner?.businessName}",
                    secondTextColor: invoiceColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Баталсан",
                    secondText: widget.data.confirmedDate != null
                        ? DateFormat("yyyy-MM-dd HH:mm")
                            .format(widget.data.confirmedDate!)
                        : '-',
                    secondTextColor: invoiceColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Баталсан дүн",
                    secondText:
                        '${Utils().formatCurrency(widget.data.confirmedAmount.toString())}₮',
                    secondTextColor: invoiceColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Үлдэгдэл дүн",
                    secondText:
                        '${Utils().formatCurrency(widget.data.amountToPay.toString())}₮',
                    secondTextColor: invoiceColor,
                    color: white,
                  ),
                ],
              ),
            isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: invoiceColor,
                    ),
                  )
                : invoice.rows!.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: const Text(
                              'Төлбөрийн түүх',
                              style: TextStyle(
                                color: grey3,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Column(
                            children: invoice.rows!
                                .map(
                                  (data) => HistoryCard(
                                    data: data,
                                    onClick: () {
                                      if (widget.data.receiverBusiness !=
                                          null) {
                                        Navigator.of(context).pushNamed(
                                          InvoiceTransactionDetail.routeName,
                                          arguments:
                                              InvoiceTransactionDetailArguments(
                                            id: '',
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      )
                    : const NotFound(
                        module: "INVOICE",
                        labelText: 'Хоосон байна',
                      ),
          ],
        ),
      ),
    );
  }
}
