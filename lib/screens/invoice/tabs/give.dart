import 'dart:async';

import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/invoice_card/invoice_card.dart';
import 'package:dehub/components/invoice_empty/invoice_empty.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/screens/invoice/new_invoice/new_invoice.dart';
import 'package:dehub/screens/invoice_detail_page/invoice_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/page_change_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';

class GivePage extends StatefulWidget {
  static const routeName = 'GivePage';
  final PageChangeController? pageChangeController;
  const GivePage({
    Key? key,
    this.pageChangeController,
  }) : super(key: key);

  @override
  State<GivePage> createState() => _GivePageState();
}

class _GivePageState extends State<GivePage>
    with AfterLayoutMixin, SingleTickerProviderStateMixin {
  bool isLoading = true;
  late TabController tabController = TabController(length: 5, vsync: this);
  int currentIndex = 0;
  int page = 1;
  Result invoice = Result(rows: [], count: 0);
  int limit = 10;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    _refreshController.refreshCompleted();
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit);
    _refreshController.refreshCompleted();
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit);
  }

  list(int page, int limit) async {
    Filter filter = Filter(query: '');
    Offset offset = Offset(limit: limit, page: page);
    Result res = await InvoiceApi()
        .listReceived(ResultArguments(filter: filter, offset: offset));
    setState(() {
      invoice = res;
      isLoading = false;
    });
  }

  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    if (widget.pageChangeController != null) {
      widget.pageChangeController?.addListener(() async {
        await list(page, limit);
      });
    }

    setState(() {
      isLoading = true;
    });

    super.initState();
  }

  void onItemTapped() {
    setState(() {
      tabController.index == currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Борлуулалтын нэхэмжлэл',
          style: TextStyle(
            fontSize: 17,
            color: invoiceColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: invoiceColor,
          ),
        ),
        actions: [
          AddButton(
            color: invoiceColor,
            onClick: () {
              Navigator.of(context).pushNamed(NewInvoice.routeName);
            },
          )
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                color: white,
                height: 50,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 5, left: 5),
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: currentIndex == 0
                            ? invoiceColor
                            : Colors.grey.shade100,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                        child: Center(
                          child: Text(
                            'Бүгд',
                            style: TextStyle(
                              fontSize: 12,
                              color: currentIndex == 0 ? white : grey2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 5, left: 5),
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: currentIndex == 1
                            ? invoiceColor
                            : Colors.grey.shade100,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                        child: Center(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'images/clock.svg',
                                color: currentIndex == 1 ? white : grey2,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Хэтэрсэн',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: currentIndex == 1 ? white : grey2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 5, left: 5),
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: currentIndex == 2
                            ? invoiceColor
                            : Colors.grey.shade100,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentIndex = 2;
                          });
                        },
                        child: Center(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'images/hesegchilsen.svg',
                                color: currentIndex == 2 ? white : grey2,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Хэсэгчилсэн',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: currentIndex == 2 ? white : grey2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 5, left: 5),
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: currentIndex == 3
                            ? invoiceColor
                            : Colors.grey.shade100,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentIndex = 3;
                          });
                        },
                        child: Center(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                color: currentIndex == 3 ? white : grey2,
                                'images/clock1.svg',
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Хүлээж буй',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: currentIndex == 3 ? white : grey2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 5, left: 5),
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: currentIndex == 4
                            ? invoiceColor
                            : Colors.grey.shade100,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentIndex = 4;
                          });
                        },
                        child: Center(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                color: currentIndex == 4 ? white : grey2,
                                'images/tulson.svg',
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Төлсөн',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: currentIndex == 4 ? white : grey2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SearchButton(
                color: invoiceColor,
              ),
            ),
          ];
        },
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
                    controller: _refreshController,
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
                        children: invoice.rows!
                            .map(
                              (item) => InvoiceCard(
                                data: item,
                                onClick: () {
                                  Navigator.of(context).pushNamed(
                                    InvoiceDetailPage.routeName,
                                    arguments:
                                        InvoiceDetailPageArguments(id: item.id),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
      ),
    );
  }
}
