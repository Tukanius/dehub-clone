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
import 'package:intl/intl.dart';

class BankDecisionTab extends StatefulWidget {
  final Finance data;
  const BankDecisionTab({
    super.key,
    required this.data,
  });

  @override
  State<BankDecisionTab> createState() => _BankDecisionTabState();
}

class _BankDecisionTabState extends State<BankDecisionTab> {
  General general = General();
  User user = User();

  symbol() {
    final res = general.currencies!
        .firstWhere((element) => element.code == widget.data.currency)
        .symbol;
    return res;
  }

  requestStatus() {
    final res = general.scfRequestStatus!
        .firstWhere((element) => element.code == widget.data.requestStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    user = Provider.of<UserProvider>(context, listen: true).financeUser;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Хүсэлтийн мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Олголтын шийдвэр',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(int.parse(
                                requestStatus().color.substring(1, 7),
                                radix: 16) +
                            0xff000000)
                        .withOpacity(0.2),
                  ),
                  child: Text(
                    '${requestStatus().name}',
                    style: TextStyle(
                      color: Color(int.parse(
                              requestStatus().color.substring(1, 7),
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
            labelText: 'Банк ажилтан',
            secondText: '${widget.data.respondedUser?.firstName}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Олгосон дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.approvedAmount.toString()) + symbol()}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Татсан SCF шимтгэл',
            secondText:
                '${Utils().formatCurrency(widget.data.totalScfFeeAmount.toString()) + symbol()}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Татсан банк шимтгэл',
            secondText:
                '${Utils().formatCurrency(widget.data.bankFeeAmount.toString()) + symbol()}',
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Олгосон огноо, цаг',
            secondText: DateFormat("yyyy-MM-dd HH:mm")
                .format(widget.data.disbursedDate!),
            secondTextColor: source.currentColor,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Эргэн төлөлтийн мэдээлэл',
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
            labelText: 'Эргэн төлөлтийн нэхэмжлэх',
            secondText: '${widget.data.repaymentInv?.refCode}',
            secondTextColor: source.currentColor,
            secondTextFontWeight: FontWeight.w500,
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
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Эргэн төлөх дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.repaymentAmount.toString()) + symbol()}',
            secondTextColor: source.currentColor,
            secondTextFontWeight: FontWeight.w500,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            labelText: 'Эргэн төлөх огноо',
            secondText: user.currentBusiness?.type == "SUPPLIER"
                ? DateFormat("yyyy-MM-dd HH: mm")
                    .format(widget.data.invPaymentDate!)
                : DateFormat("yyyy-MM-dd HH: mm").format(
                    widget.data.invPaymentDate!.add(
                      Duration(days: widget.data.product!.buyerTerm!.toInt()),
                    ),
                  ),
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
