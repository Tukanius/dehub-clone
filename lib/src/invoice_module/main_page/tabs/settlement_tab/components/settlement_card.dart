import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettlementCard extends StatefulWidget {
  final Function()? onClick;
  final Invoice data;
  const SettlementCard({
    super.key,
    required this.data,
    this.onClick,
  });

  @override
  State<SettlementCard> createState() => _SettlementCardState();
}

class _SettlementCardState extends State<SettlementCard> {
  General general = General();

  settlementStatus() {
    final res = general.settlementStatus!
        .firstWhere((element) => element.code == widget.data.settlementStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).invoiceGeneral;

    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    '${widget.data.receiverBusiness?.profileName}',
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    '#${widget.data.refCode}',
                    style: const TextStyle(
                      color: invoiceColor,
                      fontWeight: FontWeight.w500,
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
                    'Илгээсэн: ${widget.data.sentDate ?? '-'}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Нийлсэн: ${widget.data.confirmedDate ?? '-'}',
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
                    'Тооцооны сар: ${widget.data.month}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: Text(
                    '${settlementStatus().name}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const Divider(
                    color: grey2,
                    thickness: 0.5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Нийлүүлэгч',
                        style: TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Худалдан авагч',
                        style: TextStyle(
                          color: grey2,
                          fontSize: 12,
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
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '${widget.data.myFinanceStaff?.avatar}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${widget.data.myFinanceStaff?.lastName?[0]}. ${widget.data.myFinanceStaff?.firstName}',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${widget.data.financeStaff?.lastName?[0]}. ${widget.data.financeStaff?.firstName}',
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '${widget.data.financeStaff?.avatar}',
                                  ),
                                  fit: BoxFit.cover,
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
          ],
        ),
      ),
    );
  }
}
