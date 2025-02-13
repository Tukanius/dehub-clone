import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InvoiceTab extends StatefulWidget {
  final Finance data;
  const InvoiceTab({
    super.key,
    required this.data,
  });

  @override
  State<InvoiceTab> createState() => _InvoiceTabState();
}

class _InvoiceTabState extends State<InvoiceTab> {
  General general = General();
  Finance buyer = Finance();
  Finance supplier = Finance();

  @override
  void initState() {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    if (source.type == 'scf' && widget.data.type == "SUPPLIER") {
      supplier = widget.data.requestedBusiness!;
      buyer = widget.data.invReceiverBusiness!;
      supplier.finUser = widget.data.requestedFinUser;
      buyer.finUser = widget.data.finUser;
      supplier.supplierAccount = widget.data.requestedBusinessAcc;
      buyer.buyerAccount = widget.data.invReceiverBusinessAcc;
    } else if (source.type == 'scf' && widget.data.type == "BUYER") {
      buyer = widget.data.requestedBusiness!;
      supplier = widget.data.invReceiverBusiness!;
      buyer.finUser = widget.data.requestedFinUser;
      supplier.finUser = widget.data.finUser;
      buyer.supplierAccount = widget.data.requestedBusinessAcc;
      supplier.buyerAccount = widget.data.invReceiverBusinessAcc;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: const Text(
              'Нэхэмжлэхийн мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Нэхэмжлэх дугаар',
            secondText:
                '${widget.data.invoice?.refCode ?? widget.data.invRefCode}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Илгээсэн ажилтан',
            secondText:
                '${widget.data.invoice?.senderUser?.firstName ?? widget.data.invSenderUser?.firstName}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Илгээсэн огноо, цаг',
            secondText: widget.data.invoice != null
                ? DateFormat("yyyy-MM-dd HH:mm")
                    .format(widget.data.invoice!.createdAt!)
                : DateFormat("yyyy-MM-dd HH:mm")
                    .format(widget.data.invCreatedAt!),
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Баталсан ажилтан',
            secondText:
                '${widget.data.invoice?.confirmedUser?.firstName ?? widget.data.invConfirmedUser?.firstName}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Баталсан огноо, цаг',
            secondText: widget.data.invoice != null
                ? DateFormat('yyyy-MM-dd HH:mm')
                    .format(widget.data.invoice!.confirmedDate!)
                : DateFormat('yyyy-MM-dd HH:mm')
                    .format(widget.data.invCreatedAt!),
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Баталсан дүн',
            secondText:
                '${Utils().formatCurrency("${widget.data.invoice?.confirmedAmount ?? widget.data.invConfirmedAmount}") + currency()}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Төлсөн дүн',
            secondText:
                '${Utils().formatCurrency("${widget.data.invoice?.paidAmount ?? widget.data.invPaidAmount}") + currency()}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Үлдэгдэл төлбөр',
            secondText:
                '${Utils().formatCurrency("${widget.data.invoice?.amountToPay ?? widget.data.invAmountToPay}") + currency()}',
            color: white,
            secondTextColor: source.currentColor,
            secondTextFontWeight: FontWeight.w500,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Нэхэмжлэх төлөв',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: invoiceStatusColor(true),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${invoiceStatus().name}',
                    style: TextStyle(
                      color: invoiceStatusColor(false),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Төлбөрийн төлөв',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: invoicePaymentStatusColor(true),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${invoicePaymentStatus()}',
                    style: TextStyle(
                      color: invoicePaymentStatusColor(false),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Хугацаа хэтрэлт',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: Color(int.parse(
                                invoiceOverdueStatus().color.substring(1, 7),
                                radix: 16) +
                            0xff000000)
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${invoiceOverdueStatus().name}',
                    style: TextStyle(
                      color: Color(int.parse(
                              invoiceOverdueStatus().color.substring(1, 7),
                              radix: 16) +
                          0xff000000),
                    ),
                  ),
                ),
              ],
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Төлбөрийн нөхцөл',
            secondText:
                '${widget.data.invoice?.paymentTermDesc ?? widget.data.invPaymentTermDesc}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Нэхэмжлэх төлөх огноо',
                  style: TextStyle(color: dark),
                ),
                Text(
                  widget.data.invoice != null
                      ? DateFormat("yyyy-MM-dd")
                          .format(widget.data.invoice!.paymentDate!)
                      : DateFormat("yyyy-MM-dd")
                          .format(widget.data.invPaymentDate!),
                  style: TextStyle(color: source.currentColor, fontSize: 18),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Нэхэмжлэлийн баримт',
              style: TextStyle(color: grey3, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            color: white,
            child: const Row(
              children: [
                Icon(Icons.downloading_rounded),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'INV_32093282.PDF',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff151357),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Худалдан авагч тал',
              style: TextStyle(color: grey3, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ХА Захиалга №',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '-',
                  style: TextStyle(color: source.currentColor, fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Партнер',
                    style: TextStyle(color: dark),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: const TextStyle(fontFamily: 'Montserrat'),
                      children: [
                        TextSpan(
                          text: source.type == "lbf"
                              ? "${widget.data.invoice?.buyer?.partner?.refCode}, "
                              : "${buyer.partner?.refCode}, ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: source.currentColor,
                          ),
                        ),
                        TextSpan(
                          text: source.type == "lbf"
                              ? "${widget.data.invoice?.buyer?.partner?.businessName}"
                              : "${buyer.partner?.businessName}",
                          style: const TextStyle(color: grey2, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ТТД',
                  style: TextStyle(color: dark),
                ),
                Text(
                  source.type == 'lbf'
                      ? '${widget.data.invoice?.buyer?.regNumber}'
                      : '${buyer.regNumber}',
                  style: TextStyle(color: source.currentColor, fontSize: 18),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/svg/contact.svg',
                  colorFilter:
                      ColorFilter.mode(source.currentColor, BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: source.type == 'lbf'
                              ? '${widget.data.invoice?.buyer?.refCode}, '
                              : '${buyer.refCode}, ',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: source.currentColor,
                          ),
                        ),
                        TextSpan(
                          text: source.type == 'lbf'
                              ? widget.data.invoice?.buyer?.profileName
                              : buyer.profileName,
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: grey2,
                          ),
                        )
                      ],
                    ),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Дансны дугаар',
                  style: TextStyle(color: dark),
                ),
                Text(
                  source.type == 'lbf'
                      ? '${widget.data.invoice?.buyerAccount?.number}'
                      : '${buyer.buyerAccount?.number}',
                  style: TextStyle(color: source.currentColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Дансны нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  source.type == 'lbf'
                      ? '${widget.data.invoice?.buyerAccount?.name}'
                      : "${buyer.buyerAccount?.name}",
                  style: TextStyle(color: source.currentColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Санхүү ажилтан нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  source.type == 'lbf'
                      ? '${widget.data.invoice?.buyerFinUser?.firstName}'
                      : '${buyer.finUser?.firstName}',
                  style: TextStyle(color: source.currentColor),
                ),
              ],
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Санхүү ажилтан утас',
            secondText: '${widget.data.invoice?.buyerFinUser?.phone}',
            secondTextColor: source.currentColor,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Нийлүүлэгч тал',
              style: TextStyle(color: grey3, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Бор Захиалга №',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '-',
                  style: TextStyle(color: source.currentColor, fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Партнер',
                    style: TextStyle(color: dark),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: const TextStyle(fontFamily: 'Montserrat'),
                      children: [
                        TextSpan(
                          text: source.type == 'lbf'
                              ? "${widget.data.invoice?.supplier?.partner?.refCode}, "
                              : "${supplier.partner?.refCode}, ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: source.currentColor,
                          ),
                        ),
                        TextSpan(
                          text: source.type == 'lbf'
                              ? "${widget.data.invoice?.supplier?.partner?.businessName}"
                              : "${supplier.partner?.businessName}",
                          style: const TextStyle(color: grey2, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ТТД',
                  style: TextStyle(color: dark),
                ),
                Text(
                  source.type == 'lbf'
                      ? '${widget.data.invoice?.supplier?.regNumber}'
                      : '${supplier.regNumber}',
                  style: TextStyle(color: source.currentColor, fontSize: 18),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/contact.svg',
                  colorFilter:
                      ColorFilter.mode(source.currentColor, BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: source.type == 'lbf'
                              ? '${widget.data.invoice?.supplier?.refCode}, '
                              : '${supplier.refCode}, ',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: source.currentColor,
                          ),
                        ),
                        TextSpan(
                          text: source.type == 'lbf'
                              ? widget.data.invoice?.supplier?.profileName
                              : supplier.profileName,
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: grey2,
                          ),
                        )
                      ],
                    ),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Дансны дугаар',
                  style: TextStyle(color: dark),
                ),
                Text(
                  source.type == "lbf"
                      ? '${widget.data.invoice?.supplierAccount?.number}'
                      : '${supplier.supplierAccount?.number}',
                  style: TextStyle(color: source.currentColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Дансны нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  source.type == 'lbf'
                      ? '${widget.data.invoice?.supplierAccount?.name}'
                      : '${supplier.supplierAccount?.name}',
                  style: TextStyle(color: source.currentColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Санхүү ажилтан нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  source.type == 'lbf'
                      ? '${widget.data.invoice?.supplierFinUser?.firstName}'
                      : '${supplier.finUser?.firstName}',
                  style: TextStyle(color: source.currentColor),
                ),
              ],
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Санхүү ажилтан утас',
            secondText: '${widget.data.invoice?.supplierFinUser?.phone}',
            secondTextColor: source.currentColor,
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  currency() {
    final res = general.currencies!
        .firstWhere((element) => element.code == widget.data.currency)
        .symbol;
    return res;
  }

  invoicePaymentStatus() {
    if (widget.data.invoice != null) {
      final res = general.invoicePaymentStatus!
          .firstWhere(
              (element) => element.code == widget.data.invoice?.paymentStatus)
          .name;
      return res;
    } else {
      final res = general.invoicePaymentStatus!
          .firstWhere((element) => element.code == widget.data.invPaymentStatus)
          .name;
      return res;
    }
  }

  invoiceOverdueStatus() {
    if (widget.data.invoice != null) {
      final res = general.invoiceOverdueStatus!.firstWhere(
          (element) => element.code == widget.data.invoice?.overdueStatus);
      return res;
    } else {
      final res = general.invoiceOverdueStatus!.firstWhere(
          (element) => element.code == widget.data.invOverdueStatus);
      return res;
    }
  }

  invoicePaymentStatusColor(bool opacity) {
    if (opacity == false) {
      switch (widget.data.paymentStatus) {
        case "DRAFT":
          return grey;
        case "PENDING":
          return yellow;
        case "DIVIDED":
          return blue;
        case "CLOSED":
          return green;
        default:
      }
    } else {
      switch (widget.data.paymentStatus) {
        case "DRAFT":
          return grey.withOpacity(0.2);
        case "PENDING":
          return yellow.withOpacity(0.2);
        case "DIVIDED":
          return blue.withOpacity(0.2);
        case "CLOSED":
          return green.withOpacity(0.2);
        default:
      }
    }
  }

  invoiceStatusColor(bool opacity) {
    if (opacity == false) {
      switch (widget.data.invStatus ?? widget.data.invoice?.invoiceStatus) {
        case "DRAFT":
          return grey;
        case "SENT":
          return Colors.indigo;
        case "CONFIRMED":
          return lightBlue;
        case "REJECTED":
          return red;
        case "RETURNED":
          return pink;
        case "CANCELED":
          return pink;
        case "CLOSED":
          return green;
        default:
      }
    } else {
      switch (widget.data.invStatus ?? widget.data.invoice?.invoiceStatus) {
        case "DRAFT":
          return grey.withOpacity(0.2);
        case "SENT":
          return Colors.indigo.withOpacity(0.2);
        case "CONFIRMED":
          return lightBlue.withOpacity(0.2);
        case "REJECTED":
          return red.withOpacity(0.2);
        case "RETURNED":
          return pink.withOpacity(0.2);
        case "CANCELED":
          return pink.withOpacity(0.2);
        case "CLOSED":
          return green.withOpacity(0.2);
        default:
      }
    }
  }

  invoiceStatus() {
    if (widget.data.invoice != null) {
      final res = general.invoiceStatus!.firstWhere(
          (element) => element.code == widget.data.invoice?.invoiceStatus);
      return res;
    } else {
      final res = general.invoiceStatus!
          .firstWhere((element) => element.code == widget.data.invStatus);
      return res;
    }
  }
}
