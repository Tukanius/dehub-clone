import 'package:dehub/models/reference_information.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/invoice_condition_page/invoice_condition_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class ReferenceInformationCard extends StatefulWidget {
  final ReferenceInformation? data;
  final int? index;
  ReferenceInformationCard({
    Key? key,
    this.index,
    this.data,
  }) : super(key: key);

  @override
  State<ReferenceInformationCard> createState() =>
      _ReferenceInformationCardState();
}

class _ReferenceInformationCardState extends State<ReferenceInformationCard>
    with AfterLayoutMixin {
  @override
  afterFirstLayout(BuildContext context) {}

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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xffF2F2F2),
          ),
          color: white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.data!.name}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Төлбөрийн нөхцөл',
                      style: TextStyle(
                        color: networkColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 170,
                      child: Text(
                        '${widget.data!.description}',
                        style: TextStyle(
                          color: grey3,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      '${widget.data!.refCode}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        color: grey3,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Огноо, цаг',
                      style: TextStyle(
                        fontSize: 10,
                        color: grey3,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Icon(
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
