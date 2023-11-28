import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/profile/components/card.dart';
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
            InformationCard(
              labelText: 'Партнер код',
              value: partnerUser.partner?.refCode.toString(),
              marginVertical: 5,
            ),
            InformationCard(
              labelText: 'Категори',
              value: partnerUser.partner?.classification,
              marginVertical: 5,
            ),
            InformationCard(
              labelText: 'ТТД/Регистр',
              value: partnerUser.partner?.regNumber,
              marginVertical: 5,
            ),
            InformationCard(
              labelText: 'Улсын бүргэлийн гэрчилгээ',
              value: partnerUser.partner?.regNumber,
              marginVertical: 5,
            ),
            InformationCard(
              labelText: 'Аж ахуйн нэгжийн нэр',
              value: partnerUser.partner?.businessName,
              marginVertical: 5,
            ),
            InformationCard(
              labelText: 'Аж ахуйн нэгжийн нэр /Латин/',
              value: partnerUser.partner?.businessNameEng,
              marginVertical: 5,
            ),
            InformationCard(
              labelText: 'Аж ахуйн нэгжийн хэлбэр',
              value: partnerUser.partner?.legalEntityType,
              marginVertical: 5,
            ),
            InformationCard(
              labelText: 'Улсын харъяалал',
              value: partnerUser.partner?.country,
              marginVertical: 5,
            ),
            InformationCard(
              labelText: 'Өмчийн хэлбэр',
              value: partnerUser.partner?.type,
              marginVertical: 5,
            ),
            InformationCard(
              labelText: 'НӨАТ төлөгч эсэх',
              value: partnerUser.partner?.isVatPayer == true ? "Тийм" : "Үгүй",
              marginVertical: 5,
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
