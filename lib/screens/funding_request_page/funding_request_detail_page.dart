import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/screens/funding_request_page/tabs/invoice.dart';
import 'package:dehub/screens/funding_request_page/tabs/request_tab.dart';
import 'package:dehub/screens/funding_request_page/tabs/limit_tab.dart';

class FundingRequestDetailPage extends StatefulWidget {
  static const routeName = '/FundingRequestDetailPage';
  const FundingRequestDetailPage({super.key});

  @override
  State<FundingRequestDetailPage> createState() =>
      _FundingRequestDetailPageState();
}

class _FundingRequestDetailPageState extends State<FundingRequestDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: 200,
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
                  'Санхүүжилт хүсэх',
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
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: const Offset(0, 1.5),
                      ),
                    ],
                  ),
                  child: TabBar(
                    indicatorColor: financingColor,
                    labelColor: financingColor,
                    unselectedLabelColor: grey2,
                    tabs: [
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          'Нэхэмжлэх',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: Text('Хүсэлт'),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: Text('Лимит'),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              InvoiceTab(),
              RequestTab(),
              LimitTab(),
            ],
          ),
        ),
      ),
    );
  }
}
