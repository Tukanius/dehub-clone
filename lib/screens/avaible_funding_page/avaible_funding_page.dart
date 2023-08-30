import 'package:dehub/components/avaible_funding_card/avaible_funding_card.dart';
import 'package:dehub/screens/avaible_funding_page/avaible_funding_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class AvaibleFundingPage extends StatefulWidget {
  static const routeName = '/AvaibleFundingPage';
  const AvaibleFundingPage({super.key});

  @override
  State<AvaibleFundingPage> createState() => _AvaibleFundingPageState();
}

class _AvaibleFundingPageState extends State<AvaibleFundingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: 100,
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  color: financingColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(
                    color: financingColor,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.shade200,
            ),
            width: 35,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Санхүүжих боломжтой',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            AvaibleFundingCard(
              onClick: () {
                Navigator.of(context)
                    .pushNamed(AvaibleFundingDetailPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
