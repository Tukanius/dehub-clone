import 'package:dehub/models/reference_information.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class InvoiceConditionCard extends StatefulWidget {
  final Function()? onClick;
  final int? index;
  final ReferenceInformation? listType;
  final ReferenceInformation? data;
  InvoiceConditionCard({
    this.listType,
    this.data,
    Key? key,
    this.onClick,
    this.index,
  }) : super(key: key);

  @override
  State<InvoiceConditionCard> createState() => _InvoiceConditionCardState();
}

class _InvoiceConditionCardState extends State<InvoiceConditionCard>
    with AfterLayoutMixin {
  @override
  afterFirstLayout(BuildContext context) {
    print(widget.data!.toJson());
    print('======');
  }

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
            color: Color(0xffF2F2F2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.index! + 1}',
                  style: TextStyle(
                    color: grey3,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.data!.termRule == null
                        ? Text(
                            '${widget.data!.name}',
                            style: TextStyle(
                              color: networkColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            '${widget.data!.termRule}',
                            style: TextStyle(
                              color: networkColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Нэхэмжлэх нөхцөл',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 250,
                      child: Text(
                        '${widget.data!.description}',
                        style: TextStyle(
                          fontSize: 12,
                          color: grey3,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Icon(
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
