import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class Page1 extends StatefulWidget {
  const Page1({
    Key? key,
  }) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> with AfterLayoutMixin {
  Partner partnerUser = Partner();

  @override
  afterFirstLayout(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    partnerUser = Provider.of<UserProvider>(context, listen: false).partnerUser;

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
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
                      margin: const EdgeInsets.only(top: 35),
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
                      margin: const EdgeInsets.only(right: 6, top: 10),
                      child: Text(
                        '${partnerUser.user!.currentBusiness!.profileNameEng}',
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
              height: 30,
            ),
            Container(
              child: Text(
                'ЕРӨНХИЙ МЭДЭЭЛЭЛ',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                'DeHUB код',
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
              margin: const EdgeInsets.only(left: 3, right: 12),
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
                '${partnerUser.partner!.refCode}',
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
              child: Text(
                'Аж ахуйн нэгжийн нэр',
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
              margin: const EdgeInsets.only(left: 3, right: 12),
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
              child: Text(
                'Аж ахуйн нэгжийн нэр /Англи үсэг/',
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
              margin: const EdgeInsets.only(left: 3, right: 12),
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
                '${partnerUser.partner!.businessNameEng}',
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
              child: Text(
                'Аж ахуйн нэгжийн хэлбэр',
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
              margin: const EdgeInsets.only(left: 3, right: 12),
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
                '${partnerUser.partner!.legalEntityType}',
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
              child: Text(
                'Регистрийн дугаар',
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
              margin: const EdgeInsets.only(left: 3, right: 12),
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
                '${partnerUser.partner!.regNumber}',
                style: TextStyle(
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'НӨАТ төлөгч эсэх :',
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 14, color: dark),
            ),
            SizedBox(
              height: 10,
            ),
            partnerUser.partner!.isVatPayer == false
                ? Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: grey3,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            width: 1.5,
                            color: grey3,
                          ),
                        ),
                        child: Icon(
                          Icons.close_outlined,
                          color: white,
                          size: 16,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Үгүй',
                        style: TextStyle(
                          color: grey3,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                : Row(
                    children: [
                      Icon(
                        Icons.check_box,
                        color: grey3,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Тийм',
                        style: TextStyle(
                          color: grey2,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
