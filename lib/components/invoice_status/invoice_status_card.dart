import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class InvoiceStatusCard extends StatefulWidget {
  final String title;
  const InvoiceStatusCard({
    required this.title,
    super.key,
  });

  @override
  InvoiceStatusCardState createState() => InvoiceStatusCardState();
}

class InvoiceStatusCardState extends State<InvoiceStatusCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: black.withOpacity(0.7),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                  border: Border.all(width: 0.1, color: grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Бүгд: 417000₮',
                        style: TextStyle(fontSize: 10, color: grey),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    LinearPercentIndicator(
                      lineHeight: 10,
                      percent: 0.3,
                      backgroundColor: const Color(0xffEBCA6F),
                      progressColor: const Color(0xff75cccd),
                    ),
                    const Divider(
                      thickness: 0.1,
                      color: grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: const Text(
                                'Хугацаа хэвийн',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff75cccd),
                                ),
                              ),
                            ),
                            Text(
                              '200000.00₮',
                              style: TextStyle(
                                fontSize: 12,
                                color: black.withOpacity(0.5),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                          child: VerticalDivider(),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: const Text(
                                'Хугацаа хэтэрсэн',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xffEBCA6F),
                                ),
                              ),
                            ),
                            Text(
                              '217000₮.00',
                              style: TextStyle(
                                fontSize: 12,
                                color: black.withOpacity(0.5),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
