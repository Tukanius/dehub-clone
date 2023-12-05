import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InvoiceStatementCard extends StatefulWidget {
  final Function()? onClick;
  final int index;
  final bool startAnimation;
  final Invoice data;
  const InvoiceStatementCard({
    Key? key,
    required this.index,
    required this.startAnimation,
    required this.data,
    this.onClick,
  }) : super(key: key);

  @override
  State<InvoiceStatementCard> createState() => _InvoiceStatementCardState();
}

class _InvoiceStatementCardState extends State<InvoiceStatementCard> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        curve: Curves.ease,
        transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
            0,
            0),
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        padding: const EdgeInsets.all(15),
        color: white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.data.logo != null
                ? CircleAvatar(
                    radius: 20,
                    backgroundColor: grey,
                    backgroundImage: NetworkImage('${widget.data.logo}'),
                  )
                : CircleAvatar(
                    radius: 20,
                    backgroundColor: grey,
                    backgroundImage: AssetImage('images/avatar.png'),
                  ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: '${widget.data.profileName}, ',
                          style: TextStyle(color: buttonColor),
                        ),
                        TextSpan(
                          text: '${widget.data.refCode}',
                          style: TextStyle(color: invoiceColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${widget.data.partner?.businessName}',
                    style: TextStyle(color: grey2, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/inv.svg',
                        colorFilter:
                            ColorFilter.mode(invoiceColor, BlendMode.srcIn),
                      ),
                      Text(
                        '  ${widget.data.invoicesCount} ш,  ',
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${Utils().formatCurrency(widget.data.invoicesAmount.toString())}₮',
                        style: TextStyle(
                          color: invoiceColor,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/reload_failed.svg',
                      ),
                      Text(
                        '   ${widget.data.overdueInvoicesCount} ш,  ',
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${Utils().formatCurrency(widget.data.overdueInvoicesAmount.toString())}₮',
                        style: TextStyle(
                          color: invoiceColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: grey2,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
