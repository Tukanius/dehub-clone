import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/components/reference_information_card/reference_information_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
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
  bool startAnimation = false;
  int limit = 10;
  Result reference = Result(rows: [], count: 0);
  bool isLoading = true;

  list(page, limit) async {
    Filter filter = Filter(query: '');
    Offset offset = Offset(page: page, limit: limit);
    reference = await BusinessApi().referenceList(
      ResultArguments(filter: filter, offset: offset),
    );
    setState(() {
      isLoading = false;
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
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
        surfaceTintColor: backgroundColor,
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
            DashboardCard(
              boxColor: networkColor,
              padding: 8,
              labelText: 'Лавлах мэдээлэл',
              svgColor: white,
              svg: 'assets/svg/bag.svg',
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: reference.rows!
                  .map(
                    (e) => ReferenceInformationCard(
                      startAnimation: startAnimation,
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
