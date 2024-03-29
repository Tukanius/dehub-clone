import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BuyerProposalCard extends StatefulWidget {
  final Finance data;
  final Function()? onClick;
  final List<Finance>? selected;
  const BuyerProposalCard({
    super.key,
    this.onClick,
    required this.selected,
    required this.data,
  });

  @override
  State<BuyerProposalCard> createState() => _BuyerProposalCardState();
}

class _BuyerProposalCardState extends State<BuyerProposalCard> {
  General general = General();

  status() {
    final res = general.programParticipantStatus!
        .firstWhere((element) => element.code == widget.data.participantStatus);
    return res;
  }

  penaltyType() {
    final res = general.networkPenaltyTypes!
        .firstWhere((element) => element.code == widget.data.penaltyType);
    return res.name;
  }

  discountType() {
    final res = general.networkDiscountTypes!
        .firstWhere((element) => element.code == widget.data.discountType);
    return res.name;
  }

  index() {
    int index =
        widget.selected!.indexWhere((element) => element.id == widget.data.id);
    return index;
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: grey,
                    image: DecorationImage(
                      image: NetworkImage(
                        '${widget.data.logo}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.data.profileName}',
                        style: TextStyle(color: source.currentColor),
                      ),
                      Text(
                        '${widget.data.partner?.businessName}, ${widget.data.partner?.refCode}',
                        style: const TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                if (widget.selected != null)
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Checkbox(
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => BorderSide(
                          color: source.currentColor,
                          width: 2,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      activeColor: source.currentColor,
                      value: index() > -1,
                      onChanged: (value) {
                        if (widget.selected!.contains(widget.data)) {
                          setState(() {
                            widget.selected!.removeWhere(
                                (element) => element.id == widget.data.id);
                          });
                        } else {
                          setState(() {
                            widget.selected!.add(widget.data);
                          });
                        }
                      },
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
                    'Бүсийн нэр: ${widget.data.areaRegion?.name ?? '-'}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Чиглэл нэр: ${widget.data.areaDirection?.name ?? '-'}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.end,
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
                    widget.data.debtLimitStartDate != null
                        ? 'Эхлэх огноо: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.data.debtLimitStartDate!))}'
                        : 'Эхлэх огноо: -',
                    style: const TextStyle(
                      color: black,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.data.debtLimitEndDate != null
                        ? 'Дуусах огноо: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.data.debtLimitEndDate!))}'
                        : 'Дуусах огноо: -',
                    style: const TextStyle(
                      color: black,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.end,
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
                    widget.data.discountPercent != null
                        ? 'Хөнгөлөлт хувь: ${widget.data.discountPercent?.toInt()}%'
                        : 'Хөнгөлөлт хувь: Хөнгөлөлтгүй',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.data.discountPercent != null
                        ? 'Алданги хувь: ${widget.data.penaltyPercent?.toInt()}%'
                        : 'Алданги хувь: Хөнгөлөлтгүй',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.end,
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
                    widget.data.discountType != null
                        ? 'Хөнгөлөлт арга: ${discountType()}'
                        : 'Хөнгөлөлт арга: -',
                    style: const TextStyle(
                      color: black,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.data.penaltyType != null
                        ? 'Алданги арга: ${penaltyType()}'
                        : 'Алданги арга: -',
                    style: const TextStyle(
                      color: black,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    // 'Төлбөрийн нөхцөл: ${widget.data.paymentTerm?.description}',
                    '',
                    style: TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Статус: ',
                        style: TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(int.parse(status().color.substring(1, 7),
                                  radix: 16) +
                              0xff000000),
                        ),
                        child: Text(
                          '${status().name}',
                          style: const TextStyle(
                            color: white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
