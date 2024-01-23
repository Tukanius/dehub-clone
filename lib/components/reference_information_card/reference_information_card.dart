import 'package:dehub/models/reference_information.dart';
import 'package:dehub/src/network_module/screens/invoice_condition_page/invoice_condition_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ReferenceInformationCard extends StatefulWidget {
  final ReferenceInformation? data;
  final int index;
  final bool startAnimation;
  const ReferenceInformationCard({
    super.key,
    required this.startAnimation,
    required this.index,
    this.data,
  });

  @override
  State<ReferenceInformationCard> createState() =>
      _ReferenceInformationCardState();
}

class _ReferenceInformationCardState extends State<ReferenceInformationCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          InvoiceConditionPage.routeName,
          arguments: InvoiceConditionPageArguments(
            data: widget.data!,
          ),
        );
      },
      child: AnimatedContainer(
        curve: Curves.ease,
        transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
            0,
            0),
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xffF2F2F2),
          ),
          color: white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.index + 1}',
                    style: const TextStyle(
                      color: grey3,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.data!.name}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Төлбөрийн нөхцөл',
                          style: TextStyle(
                            color: networkColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${widget.data!.description}',
                          style: const TextStyle(
                            color: grey3,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      '${widget.data!.refCode}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        color: grey3,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Огноо, цаг',
                      style: TextStyle(
                        fontSize: 10,
                        color: grey3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: grey3,
                    size: 14,
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
