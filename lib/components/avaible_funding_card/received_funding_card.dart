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
  const ReceivedFundingCard({
    Key? key,
    this.onClick,
    required this.data,
  }) : super(key: key);

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
                      '${widget.data.refCode}',
                      style: TextStyle(
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
                      child: SvgPicture.asset('assets/svg/note.svg'),
                    ),
                  ],
                ),
                SizedBox(
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
                        color: green.withOpacity(0.2),
                      ),
                      child: Text(
                        'Олгосон',
                        style: TextStyle(
                            color: green,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      '${widget.data.requestedBusiness?.profileName}',
                      style: TextStyle(
                        color: source.currentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Хүсэлтийн дүн: ',
                      style: TextStyle(
                        color: Color(0xff555555),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${Utils().formatCurrency(widget.data.requestedAmount.toString()) + symbol()}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Нийт шимтгэл: ${Utils().formatCurrency(widget.data.calculatedFeeAmount.toString()) + symbol()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff555555),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/inv.svg',
                          colorFilter:
                              ColorFilter.mode(buttonColor, BlendMode.srcIn),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          '${widget.data.invRefCode}',
                          style: TextStyle(
                            color: dark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
