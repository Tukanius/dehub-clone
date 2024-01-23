import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LimitTab extends StatefulWidget {
  final Finance data;
  const LimitTab({
    super.key,
    required this.data,
  });

  @override
  State<LimitTab> createState() => _LimitTabState();
}

class _LimitTabState extends State<LimitTab> {
  General general = General();

  symbol() {
    final res = general.currencies!
        .firstWhere((element) => element.code == widget.data.currency)
        .symbol;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
          labelText: 'Баталсан лимит',
          secondText:
              '${Utils().formatCurrency(widget.data.businessSubLimit.toString())}${symbol()}',
          secondTextColor: source.currentColor,
          color: white,
        ),
        FieldCard(
          paddingHorizontal: 15,
          paddingVertical: 10,
          labelText: 'Боломжит лимит',
          secondText:
              '${Utils().formatCurrency(widget.data.businessAvailableAmount.toString())}${symbol()}',
          secondTextColor: source.currentColor,
          color: white,
        ),
        FieldCard(
          paddingHorizontal: 15,
          paddingVertical: 10,
          labelText: 'Лимит ашигласан',
          secondText:
              '${Utils().formatCurrency(widget.data.businessUtilizedAmount.toString())}${symbol()}',
          secondTextColor: source.currentColor,
          color: white,
        ),
        FieldCard(
          paddingHorizontal: 15,
          paddingVertical: 10,
          labelText: 'Олголт хүлээж буй',
          secondText:
              '${Utils().formatCurrency(widget.data.businessDisbursePendingAmount.toString())}${symbol()}',
          secondTextColor: source.currentColor,
          color: white,
        ),
        FieldCard(
          paddingHorizontal: 15,
          paddingVertical: 10,
          labelText: 'Хүсэлт илгээсэн',
          secondText:
              '${Utils().formatCurrency(widget.data.businessPendingAmount.toString())}${symbol()}',
          secondTextColor: source.currentColor,
          color: white,
        ),
        // Container(
        //   margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        //   child: Text(
        //     'Хүсэлтийн мэдээлэл',
        //     style: TextStyle(
        //       color: grey3,
        //       fontSize: 14,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        // FieldCard(
        //   paddingHorizontal: 15,
        //   paddingVertical: 10,
        //   labelText: 'Лимит ашигласан',
        //   secondText:
        //       '${Utils().formatCurrency(widget.data.businessUtilizedCount.toString())}',
        //   secondTextColor: source.currentColor,
        //   color: white,
        // ),
        // FieldCard(
        //   paddingHorizontal: 15,
        //   paddingVertical: 10,
        //   labelText: 'Олголт хүлээж буй',
        //   secondText:
        //       '${Utils().formatCurrency(widget.data.businessDisbursePendingCount.toString())}',
        //   secondTextColor: source.currentColor,
        //   color: white,
        // ),
        // FieldCard(
        //   paddingHorizontal: 15,
        //   paddingVertical: 10,
        //   labelText: 'Хүсэлт илгээсэн',
        //   secondText:
        //       '${Utils().formatCurrency(widget.data.businessPendingCount.toString())}',
        //   secondTextColor: source.currentColor,
        //   color: white,
        // ),
      ],
    );
  }
}
