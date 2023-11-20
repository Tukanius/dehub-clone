import 'dart:async';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/invoice_card/invoice_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/new_invoice.dart';
import 'package:dehub/src/invoice_module/screens/invoice_detail_page/invoice_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GivePage extends StatefulWidget {
  static const routeName = 'GivePage';
  const GivePage({
    Key? key,
  }) : super(key: key);

  @override
  State<GivePage> createState() => _GivePageState();
}

class _GivePageState extends State<GivePage>
    with AfterLayoutMixin, SingleTickerProviderStateMixin {
  List<Invoice> groupedList = [];
  bool isLoading = true;
  late TabController tabController = TabController(length: 5, vsync: this);
  int currentIndex = 0;
  int page = 1;
  Result invoice = Result(rows: [], count: 0);
  int limit = 10;
  Timer? timer;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  User user = User();
  ListenController listenController = ListenController();
  bool startAnimation = false;

  void _onLoading() async {
    setState(() {
      page += 1;
    });
    await list(page, limit, '');
    _refreshController.loadComplete();
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    setState(() {
      isLoading = true;
      page = 1;
      groupedList = [];
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    await list(page, limit, '');
    _refreshController.refreshCompleted();
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit, '');
  }

  list(int page, int limit, String query) async {
    Filter filter = Filter(query: '${query}');
    Offset offset = Offset(limit: limit, page: page);
    if (user.currentBusiness?.type == "BUYER") {
      invoice = await InvoiceApi()
          .listReceived(ResultArguments(filter: filter, offset: offset));
    } else {
      invoice = await InvoiceApi()
          .list(ResultArguments(filter: filter, offset: offset));
    }
    await makeGroup();
    setState(() {
      isLoading = false;
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  makeGroup() {
    Map<DateTime, List<Invoice>> groupItems = {};
    for (var data in invoice.rows!) {
      DateTime createdAt =
          DateTime.parse(DateFormat('yyyy-MM-dd').format(data.createdAt));
      if (groupItems.containsKey(createdAt)) {
        groupItems[createdAt]?.add(data);
      } else {
        groupItems[createdAt] = [data];
      }
    }
    groupItems.forEach((key, value) {
      groupedList.add(Invoice(
        header: key,
        values: value,
      ));
    });
  }

  @override
  void initState() {
    listenController.addListener(() {
      setState(() {
        isLoading = true;
      });
      list(page, limit, '');
    });
    super.initState();
  }

  onChange(String query) async {
    Future.delayed(Duration(milliseconds: 400), () async {
      setState(() {
        isLoading = true;
        startAnimation = false;
      });
      await list(page, limit, query);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).invoiceMe;
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
          user.currentBusiness?.type == "SUPPLIER"
              ? AddButton(
                  color: invoiceColor,
                  onClick: () {
                    Navigator.of(context).pushNamed(NewInvoice.routeName);
                  },
                )
              : SizedBox(),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
            ),
            color: white,
            height: 50,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              itemCount: filter.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.only(right: 5, left: 5),
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color:
                        currentIndex == 1 ? invoiceColor : Colors.grey.shade100,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Row(
                        children: [
                          filter[index].image != ''
                              ? SvgPicture.asset(
                                  '${filter[index].image}',
                                  colorFilter: ColorFilter.mode(
                                    currentIndex == 1 ? white : grey2,
                                    BlendMode.srcIn,
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '${filter[index].name}',
                            style: TextStyle(
                              fontSize: 12,
                              color: currentIndex == 1 ? white : grey2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SearchButton(
            onChange: (query) {
              onChange(query);
            },
            color: invoiceColor,
          ),
          isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: invoiceColor,
                  ),
                )
              : groupedList.length == 0
                  ? NotFound(
                      module: "INVOICE",
                      labelText: "Нэхэмжлэл олдсонгүй",
                    )
                  : Expanded(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        controller: _refreshController,
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
                                .map(
                                  (item) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AnimatedContainer(
                                        duration: Duration(
                                            milliseconds: 300 +
                                                (groupedList.indexOf(item) *
                                                    400)),
                                        transform: Matrix4.translationValues(
                                            startAnimation
                                                ? 0
                                                : -MediaQuery.of(context)
                                                    .size
                                                    .width,
                                            0,
                                            0),
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 10),
                                        child: Text(
                                          '${DateFormat('yyyy-MM-dd').format(item.header!)}',
                                          style: TextStyle(
                                            color: grey3,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: item.values!
                                            .map(
                                              (data) => InvoiceCard(
                                                startAnimation: startAnimation,
                                                index: (groupedList
                                                        .indexOf(item) +
                                                    item.values!.indexOf(data) +
                                                    1),
                                                data: data,
                                                onClick: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                    InvoiceDetailPage.routeName,
                                                    arguments:
                                                        InvoiceDetailPageArguments(
                                                      id: data.id!,
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                            .toList(),
                                      )
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
        ],
      ),
    );
  }

  List<Invoice> filter = [
    Invoice(
      image: '',
      name: 'Бүгд',
    ),
    Invoice(
      image: 'assets/svg/clock.svg',
      name: 'Хэтэрсэн',
    ),
    Invoice(
      image: 'assets/svg/hesegchilsen.svg',
      name: 'Хэсэгчилсэн',
    ),
    Invoice(
      image: 'assets/svg/clock1.svg',
      name: 'Хүлээж буй',
    ),
    Invoice(
      image: 'assets/svg/tulson.svg',
      name: 'Төлсөн',
    ),
  ];
}