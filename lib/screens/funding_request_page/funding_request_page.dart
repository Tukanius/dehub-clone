import 'package:dehub/components/avaible_funding_card/requested_funding_card.dart';
import 'package:dehub/screens/funding_request_page/funding_request_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class FundingRequestPage extends StatefulWidget {
  static const routeName = '/FundingRequestPage';
  const FundingRequestPage({super.key});

  @override
  State<FundingRequestPage> createState() => _FundingRequestPageState();
}

class _FundingRequestPageState extends State<FundingRequestPage> {
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
                'Санхүүжих хүсэлт',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            RequestedFundingCard(
              onClick: () {
                Navigator.of(context)
                    .pushNamed(FundingRequestDetailPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
