import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/providers/finance_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);

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
          color: white,
          labelText: 'Баталсан лимит',
          secondText:
              '${Utils().formatCurrency(widget.data.businessSubLimit.toString())}₮',
          secondTextColor: source.currentColor,
        ),
        FieldCard(
          paddingHorizontal: 15,
          paddingVertical: 10,
          color: white,
          labelText: 'Боломжит лимит',
          secondText:
              '${Utils().formatCurrency(widget.data.businessAvailableAmount.toString())}₮',
          secondTextColor: source.currentColor,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          color: white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Лимин шаардлага',
                style: TextStyle(color: dark),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: widget.data.businessAvailableAmount! >=
                          source.finance.requestedAmount!
                      ? green.withOpacity(0.2)
                      : grey2.withOpacity(0.2),
                ),
                child: Text(
                  widget.data.businessAvailableAmount! >=
                          source.finance.requestedAmount!
                      ? 'Хангасан'
                      : 'Хангаагүй',
                  style: TextStyle(
                      color: widget.data.businessAvailableAmount! >=
                              source.finance.requestedAmount!
                          ? green
                          : grey2,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        FieldCard(
          paddingHorizontal: 15,
          paddingVertical: 10,
          color: white,
          labelText: 'Лимит ашигласан',
          secondText:
              '${Utils().formatCurrency(widget.data.businessUtilizedAmount.toString())}₮',
          secondTextColor: source.currentColor,
        ),
        FieldCard(
          paddingHorizontal: 15,
          paddingVertical: 10,
          color: white,
          labelText: 'Олголт хүлээж буй',
          secondText:
              '${Utils().formatCurrency(widget.data.businessDisbursePendingAmount.toString())}₮',
          secondTextColor: source.currentColor,
        ),
        FieldCard(
          paddingHorizontal: 15,
          paddingVertical: 10,
          color: white,
          labelText: 'Хүсэлт илгээсэн',
          secondText:
              '${Utils().formatCurrency(widget.data.businessPendingAmount.toString())}₮',
          secondTextColor: source.currentColor,
        ),
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
          color: white,
          labelText: 'Лимит ашигласан',
          secondText: '${widget.data.businessUtilizedCount?.toInt()}',
          secondTextColor: source.currentColor,
        ),
        FieldCard(
          paddingHorizontal: 15,
          paddingVertical: 10,
          color: white,
          labelText: 'Олголт хүлээж буй',
          secondText: '${widget.data.businessDisbursePendingCount?.toInt()}',
          secondTextColor: source.currentColor,
        ),
        FieldCard(
          paddingHorizontal: 15,
          paddingVertical: 10,
          color: white,
          labelText: 'Хүсэлт илгээсэн',
          secondText: '${widget.data.businessPendingCount?.toInt()}',
          secondTextColor: source.currentColor,
        ),
        // Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        //   child: const Text(
        //     'Гэрээ баталгаажуулах',
        //     style: TextStyle(
        //       color: grey3,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        // Container(
        //   color: white,
        //   child: Row(
        //     children: [
        //       Checkbox(
        //         activeColor: source.currentColor,
        //         value: source.finance.isApproved ?? false,
        //         onChanged: (value) {
        //           source.contractAgreement(value!);
        //         },
        //       ),
        //       Text('Зөвшөөрөх'),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
