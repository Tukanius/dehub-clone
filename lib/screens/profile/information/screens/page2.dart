import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Page2 extends StatefulWidget {
  static const routeName = '/Page2';
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int currentIndex = 1;

  // pageChange() {
  //   switch (currentIndex) {
  //     case 1:
  //       return PartnerInfo1();
  //     case 2:
  //       return PartnerInfo2();
  //     default:
  //   }
  // }

  Partner partnerUser = Partner();

  @override
  Widget build(BuildContext context) {
    partnerUser = Provider.of<UserProvider>(context, listen: false).partnerUser;

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 18, top: 35),
                      child: Text(
                        'Дэлгэрэх хүнс ХХК',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: grey3,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 24, top: 10),
                      child: Text(
                        'Bolor Delguur',
                        style: TextStyle(
                          fontSize: 16,
                          color: grey3,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 45,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                'МАРКЕТИНГИЙН МЭДЭЭЛЭЛ',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 23,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                'Баннер зураг',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Image(
              image: NetworkImage(
                'https://cdn.corporate.walmart.com/dims4/WMT/f7a8313/2147483647/strip/true/crop/1920x1080+0+0/resize/1200x675!/quality/90/?url=https%3A%2F%2Fcdn.corporate.walmart.com%2F7b%2F66%2F142c151b4cd3a19c13e1ca65f193%2Fbusinessfornature-banner.png',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                'Лого',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: partnerUser.user!.logo != null
                    ? DecorationImage(
                        image: NetworkImage("${partnerUser.partner!.logo}"),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: AssetImage(
                          'images/invoice_empty.png',
                        ),
                        fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                'Бизнесийн нэр:',
                style: TextStyle(
                  color: dark,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 30),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                '${partnerUser.partner!.businessName}',
                style: TextStyle(
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                'Веб сайт',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 30),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                '${partnerUser.partner!.web}',
                style: TextStyle(
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                'И-мэйл хаяг',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 30),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                '${partnerUser.partner!.email}',
                style: TextStyle(
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                'Гар утасны дугаар',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 30),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                '${partnerUser.partner!.phone}',
                style: TextStyle(
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                'Facebook хаяг',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 30),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                '${partnerUser.partner!.fbLink}',
                style: TextStyle(
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 92,
            ),
          ],
        ),
      ),
    );
  }
}
