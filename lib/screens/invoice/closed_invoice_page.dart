import 'package:dehub/components/invoice_card/invoice_card.dart';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/invoice_empty/invoice_empty.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  list(page, limit) async {
    Filter filter = Filter(query: '');
    Offset offset = Offset(page: page, limit: limit);
    Result res = await InvoiceApi().listClosed(
      ResultArguments(filter: filter, offset: offset),
    );
    setState(() {
      invoice = res;
      isLoading = false;
    });
  }

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
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
          : invoice.rows!.length == 0
              ? InvoiceEmpty()
              : SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: refreshController,
                  header: WaterDropHeader(
                    waterDropColor: invoiceColor,
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
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: SearchButton(
                            borderColor: invoiceColor,
                            textColor: invoiceColor,
                            color: invoiceColor,
                          ),
                        ),
                        Column(
                          children: invoice.rows!
                              .map(
                                (e) => InvoiceCard(
                                  data: e,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
