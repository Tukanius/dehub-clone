import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

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
  User user = User();
  Finance buyerBusiness = Finance();
  Finance supplierBusiness = Finance();
  Finance buyerAcc = Finance();
  Finance supplierAcc = Finance();
  Finance buyerFinUser = Finance();
  Finance supplierFinUser = Finance();

  invoiceStatus() {
    final res = general.invoiceStatus!
        .firstWhere((element) => element.code == widget.data.invoiceStatus)
        .name;
    return res;
  }

  overdueStatus() {
    final res = general.invoiceOverdueStatus!
        .firstWhere((element) => element.code == widget.data.overdueStatus);
    return res;
  }

  paymentStatus() {
    final res = general.invoicePaymentStatus!
        .firstWhere((element) => element.code == widget.data.paymentStatus)
        .name;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    user = Provider.of<UserProvider>(context, listen: true).financeUser;
    if (widget.data.type == "SALES") {
      setState(() {
        buyerBusiness = widget.data.receiverBusiness!;
        supplierBusiness = widget.data.senderBusiness!;
        buyerAcc = widget.data.receiverAcc!;
        supplierAcc = widget.data.senderAcc!;
        buyerFinUser = widget.data.receiverFinUser!;
        supplierFinUser = widget.data.senderFinUser!;
      });
    } else {
      setState(() {
        supplierBusiness = widget.data.receiverBusiness!;
        buyerBusiness = widget.data.senderBusiness!;
        supplierAcc = widget.data.receiverAcc!;
        buyerAcc = widget.data.senderAcc!;
        supplierFinUser = widget.data.receiverFinUser!;
        buyerFinUser = widget.data.senderFinUser!;
      });
    }
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
            color: white,
            labelText: 'Нэхэмжлэх',
            secondText: '${widget.data.refCode}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Илгээсэн ажилтан',
            secondText: '${widget.data.senderUser?.firstName}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Илгээсэн огноо, цаг',
            secondText:
                DateFormat("yyyy-MM-dd HH:mm").format(widget.data.sentDate!),
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Баталсан ажилтан',
            secondText: '${widget.data.confirmedUser?.firstName}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Баталсан огноо, цаг',
            secondText: DateFormat("yyyy-MM-dd HH:mm")
                .format(widget.data.confirmedDate!),
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Баталсан дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.confirmedAmount.toString())}₮',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Төлсөн дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.paidAmount.toString())}₮',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Үлдэгдэл төлбөр',
            secondText:
                '${Utils().formatCurrency(widget.data.amountToPay.toString())}₮',
            secondTextColor: source.currentColor,
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
                    color: const Color(0xffD3E9FF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${invoiceStatus()}',
                    style: const TextStyle(
                      color: Color(0xff2290FF),
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
                    color: const Color(0xffD9E1F9),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${paymentStatus()}',
                    style: const TextStyle(
                      color: Color(0xff4169E1),
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
                                overdueStatus().color.substring(1, 7),
                                radix: 16) +
                            0xff000000)
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${overdueStatus().name}',
                    style: TextStyle(
                      color: Color(int.parse(
                              overdueStatus().color.substring(1, 7),
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
            color: white,
            labelText: 'Төлбөрийн нөхцөл',
            secondText: '${widget.data.paymentTermDesc}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Нэхэмжлэх төлөх огноо',
            secondText:
                DateFormat("yyyy-MM-dd").format(widget.data.paymentDate!),
            secondTextColor: source.currentColor,
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
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'ХА Захиалга №',
            secondText: '-',
            secondTextColor: source.currentColor,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Партнер',
                  style: TextStyle(color: dark),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 7,
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: const TextStyle(fontFamily: 'Montserrat'),
                      children: [
                        TextSpan(
                          text: '${buyerBusiness.partner?.refCode}, ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: source.currentColor,
                          ),
                        ),
                        TextSpan(
                          text: '${buyerBusiness.partner?.businessName}',
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
                  '${buyerBusiness.regNumber}',
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
                          text: '${buyerBusiness.refCode}, ',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: source.currentColor,
                          ),
                        ),
                        TextSpan(
                          text: "${buyerBusiness.profileName}",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: grey2,
                            color: grey2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Дансны дугаар',
            secondText: '${buyerAcc.number}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Дансны нэр',
            secondText: '${buyerAcc.shortName}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Банкны нэр',
            secondText: '${buyerAcc.bankName}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Санхүү ажилтан нэр',
            secondText: '${buyerFinUser.firstName}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Санхүү ажилтан утас',
            secondText: '${buyerFinUser.phone}',
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
                const Text(
                  'Партнер',
                  style: TextStyle(color: dark),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 7,
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: const TextStyle(fontFamily: 'Montserrat'),
                      children: [
                        TextSpan(
                          text: "${supplierBusiness.partner?.refCode}, ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: source.currentColor,
                          ),
                        ),
                        TextSpan(
                          text: "${supplierBusiness.partner?.businessName}",
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
                  '${supplierBusiness.regNumber}',
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
                          text: '${supplierBusiness.refCode}, ',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: source.currentColor,
                            color: source.currentColor,
                          ),
                        ),
                        TextSpan(
                          text: "${supplierBusiness.profileName}",
                          style: const TextStyle(
                            decorationColor: grey2,
                            decoration: TextDecoration.underline,
                            color: grey2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Дансны дугаар',
            secondText: '${supplierAcc.number}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Дансны нэр',
            secondText: '${supplierAcc.shortName}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Банкны нэр',
            secondText: '${supplierAcc.bankName}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Санхүү ажилтан нэр',
            secondText: '${supplierFinUser.firstName}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Санхүү ажилтан утас',
            secondText: '${supplierFinUser.phone}',
            secondTextColor: source.currentColor,
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
