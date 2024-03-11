import 'dart:async';

import 'package:dehub/components/invoice_card/invoice_card.dart';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/invoice_empty/invoice_empty.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/invoice_status.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/src/invoice_module/screens/invoice_detail_page/invoice_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  General general = General();

  list(page, limit, String query) async {
    Filter filter = Filter(query: query);
    Offset offset = Offset(page: page, limit: limit);
    invoice = await InvoiceApi().listClosed(
      ResultArguments(filter: filter, offset: offset),
    );
    await groupMaker();
    setState(() {
      isLoading = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
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
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      page = 1;
      groupItems = {};
    });
    await list(page, limit, '');
    refreshController.refreshCompleted();
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit, '');
    int index = general.invoiceStatus!
        .indexWhere((element) => element.code == "CLOSED");
    if (index < 0) {
      general.invoiceStatus?.add(
        InvoiceStatus(code: "CLOSED", name: "Хаасан", color: "#01C129"),
      );
    }
  }

  onChange(String query) async {
    if (timer != null) timer?.cancel();
    timer = Timer(const Duration(milliseconds: 400), () {
      setState(() {
        isLoading = true;
        groupItems = {};
      });
      list(page, limit, query);
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
    general =
        Provider.of<GeneralProvider>(context, listen: true).invoiceGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: invoiceColor),
        title: const Text(
          'Хаагдсан нэхэмжлэх',
          style: TextStyle(
            color: invoiceColor,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: invoiceColor,
              ),
            )
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
                  child: Refresher(
                    refreshController: refreshController,
                    onLoading: _onLoading,
                    onRefresh: _onRefresh,
                    color: invoiceColor,
                    child: SingleChildScrollView(
                      child: groupedList.isEmpty
                          ? const InvoiceEmpty()
                          : Column(
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
                                            transform:
                                                Matrix4.translationValues(
                                                    startAnimation
                                                        ? 0
                                                        : -MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                    0,
                                                    0),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            child: Text(
                                              DateFormat("yyyy-MM-dd")
                                                  .format(data.header!),
                                              style: const TextStyle(
                                                color: grey3,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: data.values!
                                                .map(
                                                  (item) => InvoiceCard(
                                                    startAnimation: true,
                                                    index: 0,
                                                    data: item,
                                                    onClick: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                        InvoiceDetailPage
                                                            .routeName,
                                                        arguments:
                                                            InvoiceDetailPageArguments(
                                                          id: item.id!,
                                                        ),
                                                      );
                                                    },
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
