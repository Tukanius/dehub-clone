import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ReceivedFundingCard extends StatefulWidget {
  final Finance data;
  final Function()? onClick;
  final Function()? paymentClick;
  const ReceivedFundingCard({
    super.key,
    this.onClick,
    this.paymentClick,
    required this.data,
  });

  @override
  State<ReceivedFundingCard> createState() => _ReceivedFundingCardState();
}

class _ReceivedFundingCardState extends State<ReceivedFundingCard> {
  General general = General();

  symbol() {
    final res = general.currencies!
        .firstWhere((element) => element.code == widget.data.currency)
        .symbol;
    return res;
  }

  requestStatus() {
    if (widget.data.lbfRequest == null) {
      final res = general.scfRequestStatus!
          .firstWhere((element) => element.code == widget.data.requestStatus);
      return res;
    } else {
      final res = general.scfRequestStatus!.firstWhere((element) =>
          element.code == widget.data.lbfRequest?.lbfRequestStatus);
      return res;
    }
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onClick,
          child: Container(
            margin: const EdgeInsets.only(bottom: 3),
            padding: const EdgeInsets.all(15),
            color: white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.data.refCode ?? widget.data.lbfRequest?.refCode}',
                      style: const TextStyle(
                          color: dark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: source.currentColor),
                        color: source.currentColor.withOpacity(0.1),
                      ),
                      child: SvgPicture.asset(
                        'assets/svg/note.svg',
                        colorFilter: ColorFilter.mode(
                            source.currentColor, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
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
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        widget.data.type == "SUPPLIER"
                            ? '${widget.data.supplier?.profileName ?? widget.data.supplierBusiness?.profileName}'
                            : '${widget.data.buyer?.profileName ?? widget.data.buyerBusiness?.profileName}',
                        style: TextStyle(
                          color: source.currentColor,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Хүсэлтийн дүн: ',
                          style: TextStyle(
                            color: Color(0xff555555),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${Utils().formatCurrency((widget.data.lbfRequest?.requestedAmount ?? widget.data.requestedAmount).toString()) + symbol()}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/inv.svg',
                            colorFilter: const ColorFilter.mode(
                                buttonColor, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            '${widget.data.invoiceRef ?? widget.data.invRefCode}',
                            style: const TextStyle(
                              color: dark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.data.totalScfFeeAmount != null
                            ? 'Нийт шимтгэл: ${Utils().formatCurrency(widget.data.totalScfFeeAmount.toString()) + symbol()}'
                            : 'Нийт шимтгэл:-',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff555555),
                        ),
                      ),
                    ),
                    if (widget.paymentClick != null)
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        color: white,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: widget.paymentClick,
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: source.currentColor, width: 1.3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: SvgPicture.asset(
                              'assets/svg/payment.svg',
                              colorFilter: ColorFilter.mode(
                                source.currentColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
