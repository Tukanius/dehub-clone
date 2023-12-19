import 'dart:async';

import 'package:dehub/components/invoice_card/invoice_card.dart';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/invoice_empty/invoice_empty.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

class ClosedInvoicePage extends StatefulWidget {
  static const routeName = '/ClosedInvoicePage';
  const ClosedInvoicePage({super.key});

  @override
  State<ClosedInvoicePage> createState() => _ClosedInvoicePageState();
}

class _ClosedInvoicePageState extends State<ClosedInvoicePage>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result invoice = Result(rows: [], count: 0);
  bool isLoading = true;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Timer? timer;
  bool startAnimation = false;
  List<Invoice> groupedList = [];
  Map<DateTime, List<Invoice>> groupItems = {};

  list(page, limit, String query) async {
    Filter filter = Filter(query: '$query');
    Offset offset = Offset(page: page, limit: limit);
    invoice = await InvoiceApi().listClosed(
      ResultArguments(filter: filter, offset: offset),
    );
    await groupMaker();
    setState(() {
      isLoading = false;
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  void _onLoading() async {
    setState(() {
      page += 1;
    });
    await list(page, limit, '');
    refreshController.loadComplete();
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      page = 1;
      groupItems = {};
    });
    await list(page, limit, '');
    refreshController.refreshCompleted();
    isLoading = false;
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit, '');
  }

  onChange(String query) async {
    if (timer != null) timer?.cancel();
    timer = Timer(Duration(milliseconds: 400), () {
      setState(() {
        isLoading = true;
        groupItems = {};
      });
      list(page, limit, query);
      setState(() {
        isLoading = false;
      });
    });
  }

  groupMaker() {
    List<Invoice> group = [];
    for (var data in invoice.rows!) {
      DateTime date =
          DateTime.parse(DateFormat("yyyy-MM-dd").format(data.createdAt));
      if (groupItems.containsKey(date)) {
        groupItems[date]!.add(data);
      } else {
        groupItems[date] = [data];
      }
    }
    groupItems.forEach((key, value) {
      setState(() {
        group.add(
          Invoice(
            header: key,
            values: value,
          ),
        );
      });
    });
    groupedList = group;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: IconThemeData(color: invoiceColor),
        title: Text(
          'Хаагдсан нэхэмжлэх',
          style: TextStyle(
            color: invoiceColor,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: invoiceColor,
              ),
            )
          : groupedList.length == 0
              ? InvoiceEmpty()
              : Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: SearchButton(
                        onChange: (query) {
                          onChange(query);
                        },
                        borderColor: invoiceColor,
                        textColor: invoiceColor,
                        color: invoiceColor,
                      ),
                    ),
                    Expanded(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        controller: refreshController,
                        header: WaterDropHeader(
                          waterDropColor: invoiceColor,
                          refresh: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: invoiceColor,
                            ),
                          ),
                        ),
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        footer: CustomFooter(
                          builder: (context, mode) {
                            Widget body;
                            if (mode == LoadStatus.idle) {
                              body = const Text("");
                            } else if (mode == LoadStatus.loading) {
                              body = const CupertinoActivityIndicator();
                            } else if (mode == LoadStatus.failed) {
                              body = const Text("Алдаа гарлаа. Дахин үзнэ үү!");
                            } else {
                              body = const Text("Мэдээлэл алга байна");
                            }
                            return SizedBox(
                              height: 55.0,
                              child: Center(child: body),
                            );
                          },
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: groupedList
                                .map((data) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AnimatedContainer(
                                          duration: Duration(
                                            milliseconds: 300 +
                                                (groupedList.indexOf(data) *
                                                    300),
                                          ),
                                          curve: Curves.ease,
                                          transform: Matrix4.translationValues(
                                              startAnimation
                                                  ? 0
                                                  : -MediaQuery.of(context)
                                                      .size
                                                      .width,
                                              0,
                                              0),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child: Text(
                                            '${DateFormat("yyyy-MM-dd").format(data.header!)}',
                                            style: TextStyle(
                                              color: grey3,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: data.values!
                                              .map(
                                                (item) => InvoiceCard(
                                                  isClosed: true,
                                                  startAnimation: true,
                                                  index: 0,
                                                  data: item,
                                                ),
                                              )
                                              .toList(),
                                        )
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
