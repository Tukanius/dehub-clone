import 'package:dehub/components/profile_field_card/profile_field_card.dart';
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
            ProfileFieldCard(
              labelText: 'Партнер код',
              text: partnerUser.partner?.refCode.toString(),
            ),
            ProfileFieldCard(
              labelText: 'Категори',
              text: partnerUser.partner?.classification,
            ),
            ProfileFieldCard(
              labelText: 'ТТД/Регистр',
              text: partnerUser.partner?.regNumber,
            ),
            ProfileFieldCard(
              labelText: 'Улсын бүргэлийн гэрчилгээ',
              text: partnerUser.partner?.regNumber,
            ),
            ProfileFieldCard(
              labelText: 'Аж ахуйн нэгжийн нэр',
              text: partnerUser.partner?.businessName,
            ),
            ProfileFieldCard(
              labelText: 'Аж ахуйн нэгжийн нэр /Латин/',
              text: partnerUser.partner?.businessNameEng,
            ),
            ProfileFieldCard(
              labelText: 'Аж ахуйн нэгжийн хэлбэр',
              text: partnerUser.partner?.legalEntityType,
            ),
            ProfileFieldCard(
              labelText: 'Улсын харъяалал',
              text: partnerUser.partner?.country,
            ),
            ProfileFieldCard(
              labelText: 'Өмчийн хэлбэр',
              text: partnerUser.partner?.type,
            ),
            ProfileFieldCard(
              labelText: 'НӨАТ төлөгч эсэх',
              text: partnerUser.partner?.isVatPayer == true ? "Тийи" : "Үгүй",
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
