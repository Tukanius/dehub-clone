import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MainInformationTab extends StatefulWidget {
  final Finance data;
  const MainInformationTab({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<MainInformationTab> createState() => _MainInformationTabState();
}

class _MainInformationTabState extends State<MainInformationTab> {
  General general = General();
  symbol() {
    final res = general.currencies!
        .firstWhere((element) => element.code == widget.data.currency);
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
              'Хүсэлтийн мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хүсэлтийн код',
            secondText: '${widget.data.refCode}',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Хүсэлт төлөв',
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
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хүсэлтийн дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.requestedAmount.toString()) + symbol().symbol}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Санхүүжилт валют',
            secondText: '${symbol().name}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Санхүүжилт хоног',
            secondText: '365',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Санхүүжилтийн шимтгэл',
            secondText:
                '${Utils().formatCurrency(widget.data.scfFeeAmount.toString()) + symbol().symbol}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Банк шимтгэл дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.bankFeeAmount.toString()) + symbol().symbol}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Бусад шимтгэл дүн',
            secondText: 'XXX,XXX,XXX.00 ₮',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Хөтөлбөрийн мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хөтөлбөрийн код',
            secondText: '${widget.data.program?.refCode}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хөтөлбөрийн нэр',
            secondText: '${widget.data.program?.name}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Бүтээгдэхүүн код',
            secondText: '${widget.data.product?.refCode}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Бүтээгдэхүүн нэр',
            secondText: '${widget.data.product?.name}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нийлүүлэгч нэр',
            secondText: '${widget.data.requestedBusiness?.profileName}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нийлүүлэгч код',
            secondText: '${widget.data.requestedBusiness?.refCode}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Партнер нэр',
            secondText:
                '${widget.data.requestedBusiness?.partner?.businessName}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Партнер код',
            secondText: '${widget.data.requestedBusiness?.partner?.refCode}',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Нэхэмжлэх мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нэхэмжлэх код',
            secondText: '${widget.data.invRefCode}',
            secondTextColor: financingColor,
            onClick: () {},
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хүсэх үеийн үлдэгдэл',
            secondText:
                '${Utils().formatCurrency(widget.data.minInvBalance.toString())}',
            secondTextFontWeight: FontWeight.w500,
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Илгээсэн огноо, цаг',
            secondText:
                '${DateFormat("yyyy-MM-dd HH:mm").format(widget.data.invCreatedAt!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Баталсан огноо, цаг',
            secondText:
                '${DateFormat("yyyy-MM-dd HH:mm").format(widget.data.invConfirmedDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Худалдан авагч код',
            secondText: '${widget.data.invReceiverBusiness?.refCode}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Худалдан авагч нэр',
            secondText: '${widget.data.invReceiverBusiness?.profileName}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Санхүү ажилтан утас',
            secondText: 'Phone_Number',
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

  requestStatus() {
    final res = general.scfRequestStatus!
        .firstWhere((element) => element.code == widget.data.requestStatus);
    return res;
  }
}
