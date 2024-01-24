import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RequestedFundingCard extends StatefulWidget {
  final Function()? onClick;
  final Finance data;
  const RequestedFundingCard({
    super.key,
    required this.data,
    this.onClick,
  });

  @override
  State<RequestedFundingCard> createState() => _RequestedFundingCardState();
}

class _RequestedFundingCardState extends State<RequestedFundingCard> {
  General general = General();

  requestStatus() {
    final res = general.scfRequestStatus!
        .firstWhere((element) => element.code == widget.data.requestStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;

    final source = Provider.of<FinanceProvider>(context, listen: true);
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.data.refCode}',
                  style: const TextStyle(
                      color: dark, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: source.currentColor),
                    color: source.currentColor.withOpacity(0.1),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/sanhuujiltS.svg',
                    colorFilter:
                        ColorFilter.mode(source.currentColor, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                Expanded(
                  child: Text(
                    '${widget.data.program?.name}',
                    style: TextStyle(
                      color: source.currentColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  'Хүсэлтийн дүн: ',
                  style: TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '${Utils().formatCurrency(widget.data.requestedAmount.toString())}₮',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${widget.data.requestedBusiness?.profileName}',
                    style: const TextStyle(
                      fontSize: 12,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нийт шимтгэл: ${Utils().formatCurrency(widget.data.totalScfFeeAmount.toString())}₮',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff555555),
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/svg/inv.svg'),
                    Text(
                      ' ${widget.data.invRefCode}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
