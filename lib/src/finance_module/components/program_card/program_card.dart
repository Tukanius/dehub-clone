import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProgramCard extends StatefulWidget {
  final Finance data;
  final String financeType;
  final Function()? onClick;
  const ProgramCard({
    super.key,
    required this.financeType,
    this.onClick,
    required this.data,
  });

  @override
  State<ProgramCard> createState() => _ProgramCardState();
}

class _ProgramCardState extends State<ProgramCard> {
  General general = General();

  programStatus() {
    dynamic res;
    if (widget.financeType == "SCF") {
      res = general.lbfProgramStatus!
          .firstWhere((element) => element.code == widget.data.programStatus)
          .name;
    } else {
      res = general.lbfProgramStatus!
          .firstWhere((element) => element.code == widget.data.lbfProgramStatus)
          .name;
    }
    return res;
  }

  statusColor() {
    switch (widget.data.programStatus ?? widget.data.lbfProgramStatus) {
      case "INACTIVE":
        return blue;
      case "ACTIVE":
        return green;
      case "CLOSED":
        return grey2;
      case "CANCELLED":
        return red;
      default:
        grey2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${widget.data.name}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: statusColor(),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Text(
                    '${programStatus()}',
                    style: TextStyle(
                      color: statusColor(),
                    ),
                  ),
                ),
                Text(
                  '${widget.data.refCode}',
                  style: TextStyle(
                    color: source.currentColor,
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
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        color: grey2,
                      ),
                      children: [
                        const TextSpan(text: 'Боломжит дүн: '),
                        TextSpan(
                          text: widget.financeType == "SCF"
                              ? "${Utils().formatCurrency(widget.data.programLimit.toString())}₮"
                              : "${Utils().formatCurrency(widget.data.lbfProgramLimit.toString())}₮",
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
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        color: grey2,
                      ),
                      children: [
                        const TextSpan(text: 'Лимит: '),
                        TextSpan(
                          text: widget.financeType == "SCF"
                              ? "${Utils().formatCurrency(widget.data.programLimit.toString())}₮"
                              : "${Utils().formatCurrency(widget.data.lbfProgramLimit.toString())}₮",
                        ),
                      ],
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
                  child: Text(
                    widget.financeType == "SCF"
                        ? '${widget.data.product?.name}'
                        : '${widget.data.lbfProduct?.name}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  widget.financeType == "SCF"
                      ? '${widget.data.product?.refCode}'
                      : '${widget.data.lbfProduct?.refCode}',
                  style: const TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
