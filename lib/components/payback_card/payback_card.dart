import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaybackCard extends StatefulWidget {
  final Function()? onClick;
  const PaybackCard({
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  State<PaybackCard> createState() => _PaybackCardState();
}

class _PaybackCardState extends State<PaybackCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'REP-INV-100064',
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: financingColor),
                    color: financingColor.withOpacity(0.1),
                  ),
                  child: SvgPicture.asset('assets/svg/note.svg'),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: yellow.withOpacity(0.2),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Text(
                    'Хүлээж буй',
                    style: TextStyle(
                      color: yellow,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  'Supplier_user',
                  style: TextStyle(
                    color: financingColor,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Төлбөрийн үлдэгдэл: ',
                  style: TextStyle(
                    color: grey2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '49,510,000.00₮',
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Эргэн төлөх огноо: DateTime ',
                    style: TextStyle(
                      color: depBrown,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Montserrat",
                      ),
                      children: [
                        TextSpan(
                          text: 'Хугацаа: ',
                          style: TextStyle(color: depBrown),
                        ),
                        TextSpan(
                          text: 'Хэвийн',
                          style: TextStyle(color: green),
                        ),
                      ],
                    ),
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
