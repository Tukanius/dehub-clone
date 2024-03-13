import 'package:dehub/models/reference_information.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class InvoiceConditionCard extends StatefulWidget {
  final Function()? onClick;
  final int? index;
  final ReferenceInformation? listType;
  final ReferenceInformation? data;
  const InvoiceConditionCard({
    this.listType,
    this.data,
    super.key,
    this.onClick,
    this.index,
  });

  @override
  State<InvoiceConditionCard> createState() => _InvoiceConditionCardState();
}

class _InvoiceConditionCardState extends State<InvoiceConditionCard>
    with AfterLayoutMixin {
  @override
  afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xffF2F2F2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.index! + 1}',
                    style: const TextStyle(
                      color: grey3,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.data?.termRule ?? widget.data?.name ?? widget.data?.description}',
                          style: const TextStyle(
                            color: networkColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Нэхэмжлэх нөхцөл',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 250,
                          child: Text(
                            '${widget.data?.description}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: grey3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: grey2,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
