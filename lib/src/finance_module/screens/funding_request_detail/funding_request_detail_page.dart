import 'package:dehub/api/finance_api.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/src/finance_module/screens/funding_request_detail/tabs/invoice.dart';
import 'package:dehub/src/finance_module/screens/funding_request_detail/tabs/request_tab.dart';
import 'package:dehub/src/finance_module/screens/funding_request_detail/tabs/limit_tab.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

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
    super.key,
    required this.id,
  });

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
    final source = Provider.of<FinanceProvider>(context, listen: false);
    get = await FinanceApi().requestGet(source.url, widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: 205,
        elevation: 0,
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
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
                  color: source.currentColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Илгээсэн хүсэлт',
                  style: TextStyle(
                    color: source.currentColor,
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
        length: source.type == "BUYER_LED" ? 3 : 2,
        child: Column(
          children: [
            Material(
              elevation: 3,
              color: white,
              child: TabBar(
                overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
                indicatorColor: source.currentColor,
                labelColor: source.currentColor,
                unselectedLabelColor: grey2,
                tabs: source.type == "BUYER_LED"
                    ? [
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          child: const Text('Нэхэмжлэх'),
                        ),
                        Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: const Text('Хүсэлт'),
                        ),
                        Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: const Text('Лимит'),
                        ),
                      ]
                    : [
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          child: const Text('Нэхэмжлэх'),
                        ),
                        Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: const Text('Хүсэлт'),
                        ),
                      ],
              ),
            ),
            Expanded(
              child: isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: source.currentColor,
                      ),
                    )
                  : TabBarView(
                      children: source.type == "BUYER_LED"
                          ? [
                              InvoiceTab(
                                data: get,
                              ),
                              RequestTab(
                                data: get,
                              ),
                              LimitTab(
                                data: get,
                              ),
                            ]
                          : [
                              InvoiceTab(
                                data: get,
                              ),
                              RequestTab(
                                data: get,
                              ),
                            ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
