import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/scaffold_messenger/scaffold_messenger.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/user_provider.dart';
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
  static const routeName = '/AvaibleFundingDetailPage';
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
  User user = User();

  @override
  void initState() {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    tabController =
        TabController(length: source.type == "BUYER_LED" ? 3 : 2, vsync: this);
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
    source.clearData();
    get = await FinanceApi()
        .financeableGet(source.url, widget.id, widget.programId);
    source.requestedAmount(get.amountToPay);
    setState(() {
      isLoading = false;
    });
  }

  onSubmit() async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    if (source.finance.requestedAmount != null) {
      Navigator.of(context).pushNamed(
        PinCheckScreen.routeName,
        arguments: PinCheckScreenArguments(
          onSubmit: () async {
            Finance data = Finance();
            data.programId = widget.programId;
            if (source.type == "SUPPLIER_LED") {
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
              if (source.finance.contractFile != null) {
                data.contractFiles = ['${source.finance.contractFile}'];
              } else {
                setState(() {
                  tabController.index = 1;
                });
                customScaffoldMessenger(
                  context,
                  color: source.currentColor,
                  labelText: 'Файл хавсаргана уу.',
                );
              }
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
      setState(() {
        tabController.index = 1;
      });
      customScaffoldMessenger(
        context,
        color: source.currentColor,
        labelText: 'Санхүүжилт хүсэх дүн оруулна уу.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    user = Provider.of<UserProvider>(context, listen: true).financeUser;
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
                const SizedBox(
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
              shape: BoxShape.circle,
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
          : Column(
              children: [
                Material(
                  color: white,
                  elevation: 4,
                  child: TabBar(
                    overlayColor:
                        MaterialStatePropertyAll(Colors.grey.shade100),
                    controller: tabController,
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
                  child: TabBarView(
                    controller: tabController,
                    children: source.type == "BUYER_LED"
                        ? [
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
                                    shape: const CircleBorder(),
                                    onPressed: () {
                                      tabController
                                          .animateTo(tabController.index + 1);
                                    },
                                    backgroundColor: source.currentColor,
                                    child: const Icon(
                                      Icons.fast_forward_outlined,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                RequestTab(
                                  userType: user.currentBusiness!.type!,
                                  data: get,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  alignment: Alignment.bottomRight,
                                  child: FloatingActionButton.small(
                                    shape: const CircleBorder(),
                                    hoverColor: source.currentColor,
                                    onPressed: () {
                                      tabController
                                          .animateTo(tabController.index + 1);
                                    },
                                    backgroundColor: source.currentColor,
                                    child: const Icon(
                                      Icons.fast_forward_outlined,
                                      color: white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 80, vertical: 20),
                                  alignment: Alignment.bottomRight,
                                  child: FloatingActionButton.small(
                                    hoverColor: source.currentColor,
                                    shape: const CircleBorder(),
                                    onPressed: () {
                                      tabController
                                          .animateTo(tabController.index - 1);
                                    },
                                    backgroundColor: source.currentColor,
                                    child: const Icon(
                                      Icons.fast_rewind_outlined,
                                      color: white,
                                    ),
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
                                        border: Border.all(
                                            color: source.currentColor),
                                      ),
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        'Санхүүжилт хүсэх',
                                        style: TextStyle(
                                          color: source.currentColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  alignment: Alignment.bottomLeft,
                                  child: FloatingActionButton.small(
                                    hoverColor: source.currentColor,
                                    shape: const CircleBorder(),
                                    onPressed: () {
                                      tabController
                                          .animateTo(tabController.index - 1);
                                    },
                                    backgroundColor: source.currentColor,
                                    child: const Icon(
                                      Icons.fast_rewind_outlined,
                                      color: white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ]
                        : [
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
                                    shape: const CircleBorder(),
                                    onPressed: () {
                                      tabController
                                          .animateTo(tabController.index + 1);
                                    },
                                    backgroundColor: source.currentColor,
                                    child: const Icon(
                                      Icons.fast_forward_outlined,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                RequestTab(
                                  userType: source.type,
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
                                        border: Border.all(
                                            color: source.currentColor),
                                      ),
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        'Санхүүжилт хүсэх',
                                        style: TextStyle(
                                          color: source.currentColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  alignment: Alignment.bottomLeft,
                                  child: FloatingActionButton.small(
                                    hoverColor: source.currentColor,
                                    shape: const CircleBorder(),
                                    onPressed: () {
                                      tabController
                                          .animateTo(tabController.index - 1);
                                    },
                                    backgroundColor: source.currentColor,
                                    child: const Icon(
                                      Icons.fast_rewind_outlined,
                                      color: white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                  ),
                ),
              ],
            ),
    );
  }
}
