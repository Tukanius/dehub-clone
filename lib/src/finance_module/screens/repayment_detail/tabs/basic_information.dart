import 'package:dehub/components/custom_switch/custom_switch.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BasicInformation extends StatefulWidget {
  final Finance data;
  const BasicInformation({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  General general = General();

  symbol() {
    final res = general.currencies!.firstWhere(
        (element) => element.code == widget.data.payerAcc?.currency);
    return res;
  }

  repaymentStatus() {
    final res = general.repaymentStatus!
        .firstWhere((element) => element.code == widget.data.repaymentStatus);
    return res;
  }

  overDue() {
    final res = general.repaymentOverDueStatus!
        .firstWhere((element) => element.code == widget.data.overdueStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Эргэн төлөлтийн нэхэмжлэх',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'ЭТН код',
            secondText: '${widget.data.refCode}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Үүссэн огноо, цаг',
            secondText:
                '${DateFormat("yyyy-MM-dd HH:mm").format(widget.data.createdAt!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Эргэн төлөх огноо',
            secondText:
                '${DateFormat("yyyy-MM-dd").format(widget.data.repaymentDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'ЭТН дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.repaymentAmount.toString()) + symbol().symbol}',
            secondTextFontWeight: FontWeight.w500,
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Төлсөн дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.paidAmount.toString()) + symbol().symbol}',
            secondTextFontWeight: FontWeight.w500,
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Төлбөрийн үлдэгдэл',
            secondText:
                '${Utils().formatCurrency(widget.data.amountToPay.toString()) + symbol().symbol}',
            secondTextFontWeight: FontWeight.w500,
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Санхүүжилт авсан огноо',
            secondText:
                '${DateFormat("yyyy-MM-dd HH:mm").format(widget.data.updatedAt!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ЭНТ төлөлт төлөв'),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(int.parse(
                                repaymentStatus().color.substring(1, 7),
                                radix: 16) +
                            0xff000000)
                        .withOpacity(0.2),
                  ),
                  child: Text(
                    '${repaymentStatus().name}',
                    style: TextStyle(
                      color: Color(
                        int.parse(repaymentStatus().color.substring(1, 7),
                                radix: 16) +
                            0xff000000,
                      ),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
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
                Text('ЭТН хугацаа хэтрэлт'),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(int.parse(overDue().color.substring(1, 7),
                                radix: 16) +
                            0xff000000)
                        .withOpacity(0.2),
                  ),
                  child: Text(
                    '${overDue().name}',
                    style: TextStyle(
                      color: Color(int.parse(overDue().color.substring(1, 7),
                              radix: 16) +
                          0xff000000),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хугацаа хэтэрсэн хоног',
            secondText: '0',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хугацаа хэтрэлтийн мэдээлэл',
            secondText: '0',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Хөтөлбөрийн мэдээлэл',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хөтөлбөрийн код',
            secondText: 'Program_Ref#',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хөтөлбөрийн нэр',
            secondText: 'Program_Name',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Буцаан дуудах эсэх'),
                CustomSwitch(
                  color: Color(0xff151357),
                  isDefault: true,
                ),
              ],
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Буцаан дуудсан',
            secondText: 'Үгүй',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нэхэмжлэх код',
            secondText: '${widget.data.invRefCode}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хүсэлтийн код',
            secondText: 'Fin_Req_#',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Олголтын код',
            secondText: 'Dis_Ref#',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Хүсэлтийн төлөв'),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: green.withOpacity(0.2),
                  ),
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      color: green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Худалдан авагч тал',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нийлүүлэгч нэр',
            secondText: 'Buyer_Name',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нийлүүлэгч код',
            secondText: 'Buyer_Ref#',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Партнер нэр',
            secondText: 'Partner_Name',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Партнер код',
            secondText: 'Partner_ref#',
            secondTextColor: financingColor,
            color: white,
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
