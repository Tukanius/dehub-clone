import 'package:dehub/api/finance_api.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/src/finance_module/screens/funding_request_detail/tabs/invoice.dart';
import 'package:dehub/src/finance_module/screens/funding_request_detail/tabs/request_tab.dart';
import 'package:dehub/src/finance_module/screens/funding_request_detail/tabs/limit_tab.dart';
import 'package:after_layout/after_layout.dart';

class FundingRequestDetailPageArguments {
  String id;
  FundingRequestDetailPageArguments({
    required this.id,
  });
}

class FundingRequestDetailPage extends StatefulWidget {
  final String id;
  static const routeName = '/FundingRequestDetailPage';
  const FundingRequestDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<FundingRequestDetailPage> createState() =>
      _FundingRequestDetailPageState();
}

class _FundingRequestDetailPageState extends State<FundingRequestDetailPage>
    with AfterLayoutMixin {
  Finance get = Finance();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    get = await FinanceApi().requestGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

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
          body: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: financingColor,
                  ),
                )
              : TabBarView(
                  children: [
                    InvoiceTab(
                      data: get,
                    ),
                    RequestTab(
                      data: get,
                    ),
                    LimitTab(
                      data: get,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
