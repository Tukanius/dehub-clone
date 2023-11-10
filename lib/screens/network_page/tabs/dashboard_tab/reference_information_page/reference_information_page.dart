import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/reference_information_card/reference_information_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';

class ReferenceInformationPage extends StatefulWidget {
  static const routeName = '/ReferenceInformationPage';
  const ReferenceInformationPage({super.key});

  @override
  State<ReferenceInformationPage> createState() =>
      _ReferenceInformationPageState();
}

class _ReferenceInformationPageState extends State<ReferenceInformationPage>
    with AfterLayoutMixin {
  int index = 1;
  int page = 1;
  int limit = 10;
  Result reference = Result(rows: [], count: 0);
  bool isLoading = true;

  list(page, limit) async {
    Filter filter = Filter(query: '');
    Offset offset = Offset(page: page, limit: limit);
    Result res = await BusinessApi().referenceList(
      ResultArguments(filter: filter, offset: offset),
    );
    setState(() {
      reference = res;
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leadingWidth: 100,
        leading: CustomBackButton(color: networkColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Network удирдлага',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: white,
              ),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 5),
              width: 100,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: networkColor,
                    ),
                    child: SvgPicture.asset(
                      'assets/svg/bag.svg',
                      color: white,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Лавлах мэдээлэл',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    softWrap: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: reference.rows!
                  .map(
                    (e) => ReferenceInformationCard(
                      index: reference.rows!.indexOf(e),
                      data: e,
                    ),
                  )
                  .toList(),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
