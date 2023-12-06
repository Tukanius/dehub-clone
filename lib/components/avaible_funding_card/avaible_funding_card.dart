import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_detail/avaible_funding_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AvaibleFundingCard extends StatefulWidget {
  final Function()? onClick;
  const AvaibleFundingCard({Key? key, this.onClick}) : super(key: key);

  @override
  State<AvaibleFundingCard> createState() => _AvaibleFundingCardState();
}

class _AvaibleFundingCardState extends State<AvaibleFundingCard> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AvaibleFundingDetailPage.routeName);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Buyer Business Name',
                  style: TextStyle(
                      color: dark, fontSize: 14, fontWeight: FontWeight.w600),
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
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: yellow.withOpacity(0.2),
                  ),
                  child: Text(
                    'Хүлээж буй',
                    style: TextStyle(
                        color: yellow,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  '10,200,200.00 ₮',
                  style: TextStyle(
                    color: dark,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '2021-12-01 15:05 PM',
                  style: TextStyle(
                    color: Color(0xff555555),
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/inv.svg',
                      colorFilter:
                          ColorFilter.mode(buttonColor, BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'INV 23897',
                      style: TextStyle(
                        color: dark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Төлөх: 2021-12-02',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff555555),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Хугацаа: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff555555),
                      ),
                    ),
                    Text(
                      'Хэвийн',
                      style: TextStyle(
                        fontSize: 12,
                        color: green,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
