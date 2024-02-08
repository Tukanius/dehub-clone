import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LimitUsageCard extends StatefulWidget {
  final Finance data;
  const LimitUsageCard({
    super.key,
    required this.data,
  });

  @override
  State<LimitUsageCard> createState() => _LimitUsageCardState();
}

class _LimitUsageCardState extends State<LimitUsageCard> {
  General general = General();

  programStatus() {
    final res = general.lbfProgramStatus!
        .firstWhere((element) => element.code == widget.data.programStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${widget.data.refCode}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: source.currentColor,
                  ),
                ),
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
              Expanded(
                child: Text(
                  '${widget.data.name}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue),
                ),
                child: Text(
                  '${programStatus().name}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: grey2,
                      fontFamily: "Montserrat",
                      fontSize: 12,
                    ),
                    children: [
                      const TextSpan(text: 'Лимит: '),
                      TextSpan(
                        text:
                            '${Utils().formatCurrency(widget.data.subLimit.toString())}₮',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    style: const TextStyle(
                      color: grey2,
                      fontFamily: "Montserrat",
                      fontSize: 12,
                    ),
                    children: [
                      const TextSpan(text: 'Боломжит: '),
                      TextSpan(
                        text:
                            '${Utils().formatCurrency(widget.data.availableAmount.toString())}₮',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
