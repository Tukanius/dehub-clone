import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MainInformationTab extends StatefulWidget {
  final Finance data;
  const MainInformationTab({
    super.key,
    required this.data,
  });

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
    final source = Provider.of<FinanceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;

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
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хүсэлтийн код',
            secondText: '${widget.data.refCode}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          // Container(
          //   color: white,
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text(
          //         'Хүсэлт төлөв',
          //         style: TextStyle(color: dark),
          //       ),
          //       Container(
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(5),
          //           color: Color(int.parse(
          //                       requestStatus().color.substring(1, 7),
          //                       radix: 16) +
          //                   0xff000000)
          //               .withOpacity(0.2),
          //         ),
          //         child: Text(
          //           '${requestStatus().name}',
          //           style: TextStyle(
          //             color: Color(int.parse(
          //                     requestStatus().color.substring(1, 7),
          //                     radix: 16) +
          //                 0xff000000),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хүсэлтийн дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.requestedAmount.toString()) + symbol().symbol}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Санхүүжилт валют',
            secondText: '${symbol().name}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          // FieldCard(
          //   paddingHorizontal: 15,
          //   paddingVertical: 10,
          //   labelText: 'Санхүүжилт хоног',
          //   secondText:
          //       '${widget.data.invoice?.paymentDate!.difference(widget.data.disbursedDate!).inDays} хоног',
          //   secondTextColor: source.currentColor,
          //   color: white,
          // ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Санхүүжилтийн шимтгэл',
            secondText:
                '${Utils().formatCurrency(widget.data.totalScfFeeAmount.toString()) + symbol().symbol}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Банк шимтгэл дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.bankFeeAmount.toString()) + symbol().symbol}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Хөтөлбөрийн мэдээлэл',
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
            labelText: 'Хөтөлбөрийн код',
            secondText:
                '${widget.data.lbfProgram?.refCode ?? widget.data.program?.refCode}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хөтөлбөрийн нэр',
            secondText:
                '${widget.data.lbfProgram?.name ?? widget.data.program?.name}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Бүтээгдэхүүн код',
            secondText:
                '${widget.data.lbfProduct?.refCode ?? widget.data.product?.refCode}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Бүтээгдэхүүн нэр',
            secondText:
                '${widget.data.lbfProduct?.name ?? widget.data.product?.name}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Нийлүүлэгч нэр',
            secondText: '${widget.data.requestedBusiness?.profileName}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Нийлүүлэгч код',
            secondText: '${widget.data.requestedBusiness?.refCode}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Партнер нэр',
            secondText:
                '${widget.data.requestedBusiness?.partner?.businessName}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Партнер код',
            secondText: '${widget.data.requestedBusiness?.partner?.refCode}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Нэхэмжлэх мэдээлэл',
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
            labelText: 'Нэхэмжлэх код',
            secondText: '${widget.data.invoice?.refCode}',
            secondTextColor: source.currentColor,
            onClick: () {},
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
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Баталсан огноо, цаг',
            secondText: widget.data.invoice != null
                ? DateFormat("yyyy-MM-dd HH:mm")
                    .format(widget.data.invoice!.confirmedDate!)
                : DateFormat("yyyy-MM-dd HH:mm")
                    .format(widget.data.invConfirmedDate!),
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Худалдан авагч код',
            secondText:
                '${widget.data.invoice?.buyer?.refCode ?? widget.data.invReceiverBusiness?.refCode}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Худалдан авагч нэр',
            secondText:
                '${widget.data.invoice?.buyer?.profileName ?? widget.data.invReceiverBusiness?.profileName}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Санхүү ажилтан утас',
            secondText: widget.data.invoice?.buyerFinUser?.phone ??
                widget.data.finUser?.phone ??
                '-',
            secondTextColor: source.currentColor,
            color: white,
          ),
          const SizedBox(
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
