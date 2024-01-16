import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/scaffold_messenger/scaffold_messenger.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/auth/pin_check/pin_check.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_detail/tabs/invoice.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_detail/tabs/limit_tab.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_detail/tabs/request_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class AvaibleFundingDetailPageArguments {
  String id;
  String programId;
  AvaibleFundingDetailPageArguments({
    required this.id,
    required this.programId,
  });
}

class AvaibleFundingDetailPage extends StatefulWidget {
  static const routeName = '/avaiblefundingdetailpage';
  final String id;
  final String programId;
  const AvaibleFundingDetailPage({
    super.key,
    required this.id,
    required this.programId,
  });

  @override
  State<AvaibleFundingDetailPage> createState() =>
      _AvaibleFundingDetailPageState();
}

class _AvaibleFundingDetailPageState extends State<AvaibleFundingDetailPage>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  ScrollController scrollController = ScrollController();
  late TabController tabController;
  Finance get = Finance();
  bool isLoading = true;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  changePage(index) {
    setState(() {
      index = tabController.index;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    get = await FinanceApi()
        .financeableGet(source.url, widget.id, widget.programId);
    setState(() {
      isLoading = false;
    });
  }

  onSubmit() async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    if (source.finance.requestedAmount != null &&
        source.finance.isApproved == true) {
      Navigator.of(context).pushNamed(
        PinCheckScreen.routeName,
        arguments: PinCheckScreenArguments(
          onSubmit: () async {
            Finance data = Finance();
            data.programId = widget.programId;
            if (source.finance.productType == "SUPPLIER_LED") {
              data.invoices = [
                Finance(
                  id: widget.id,
                  requestedAmount: source.finance.requestedAmount,
                ),
              ];
              await FinanceApi().supplierLedCreate(source.url, data);
            } else {
              data.invId = widget.id;
              data.requestedAmount = source.finance.requestedAmount;
              data.contractFile = source.finance.contractFile;
              await FinanceApi().buyerLedCreate(source.url, data);
            }

            showCustomDialog(context, "Хүсэлт амжилттай илгээгдлээ", true,
                onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });
          },
          color: source.currentColor,
          labelText: "SCF Хүсэлт батлах",
          description:
              'Та SCF хүсэлт батлах гэж байна. Та мэдээллээ сайтар шалгана уу.',
        ),
      );
    } else {
      if (source.finance.isApproved != true) {
        CustomScaffoldMessenger(context,
            color: source.currentColor, labelText: 'Гэрээ баталгаажуулна уу');
      } else {
        setState(() {
          tabController.index = 1;
        });
        CustomScaffoldMessenger(
          context,
          color: source.currentColor,
          labelText: 'Санхүүжилт хүсэх дүн оруулна уу.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 205,
        surfaceTintColor: backgroundColor,
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
                  color: source.currentColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Санхүүжилт хүсэх',
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
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: source.currentColor,
              ),
            )
          : DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: Material(
                        color: white,
                        elevation: 4,
                        child: TabBar(
                          overlayColor:
                              MaterialStatePropertyAll(Colors.grey.shade100),
                          controller: tabController,
                          indicatorColor: source.currentColor,
                          labelColor: source.currentColor,
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
                  controller: tabController,
                  children: [
                    Stack(
                      children: [
                        InvoiceTab(
                          data: get,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton.small(
                            hoverColor: source.currentColor,
                            shape: CircleBorder(),
                            onPressed: () {
                              tabController.animateTo(tabController.index + 1);
                            },
                            child: Icon(
                              Icons.fast_forward_outlined,
                              color: white,
                            ),
                            backgroundColor: source.currentColor,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        RequestTab(
                          data: get,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton.small(
                            shape: CircleBorder(),
                            hoverColor: source.currentColor,
                            onPressed: () {
                              tabController.animateTo(tabController.index + 1);
                            },
                            child: Icon(
                              Icons.fast_forward_outlined,
                              color: white,
                            ),
                            backgroundColor: source.currentColor,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 20),
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton.small(
                            hoverColor: source.currentColor,
                            shape: CircleBorder(),
                            onPressed: () {
                              tabController.animateTo(tabController.index - 1);
                            },
                            child: Icon(
                              Icons.fast_rewind_outlined,
                              color: white,
                            ),
                            backgroundColor: source.currentColor,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        LimitTab(
                          data: get,
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: GestureDetector(
                            onTap: () {
                              onSubmit();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: source.currentColor),
                              ),
                              child: Text(
                                'Санхүүжилт хүсэх',
                                style: TextStyle(
                                  color: source.currentColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              alignment: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          alignment: Alignment.bottomLeft,
                          child: FloatingActionButton.small(
                            hoverColor: source.currentColor,
                            shape: CircleBorder(),
                            onPressed: () {
                              tabController.animateTo(tabController.index - 1);
                            },
                            child: Icon(
                              Icons.fast_rewind_outlined,
                              color: white,
                            ),
                            backgroundColor: source.currentColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
