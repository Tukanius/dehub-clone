import 'dart:async';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/invoice_card/invoice_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/invoice_status.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/new_invoice.dart';
import 'package:dehub/src/invoice_module/screens/invoice_detail_page/invoice_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GivePage extends StatefulWidget {
  static const routeName = 'GivePage';
  const GivePage({
    super.key,
  });

  @override
  State<GivePage> createState() => _GivePageState();
}

class _GivePageState extends State<GivePage>
    with AfterLayoutMixin, SingleTickerProviderStateMixin {
  List<Invoice> groupedList = [];
  bool isLoading = true;
  int page = 1;
  Result invoice = Result(rows: [], count: 0);
  int limit = 10;
  Timer? timer;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  User user = User();
  ListenController listenController = ListenController();
  bool startAnimation = false;
  Map<DateTime, List<Invoice>> groupItems = {};
  General general = General();
  String? selectedStatus = '';
  String search = '';
  InvoiceStatus filterAll = InvoiceStatus(code: '', name: 'Бүгд');

  void _onLoading() async {
    setState(() {
      page += 1;
    });
    await list(page, limit, '', selectedStatus!);
    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    setState(() {
      isLoading = true;
      page = 1;
      groupItems = {};
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    await list(page, limit, '', selectedStatus!);
    _refreshController.refreshCompleted();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    int? index =
        general.invoiceStatus?.indexWhere((element) => element.code == '');
    if (index! < 0) {
      general.invoiceStatus?.insert(0, filterAll);
    }
    general.invoiceStatus?.removeWhere((element) => element.code == "CLOSED");
    await list(page, limit, '', selectedStatus!);
  }

  list(int page, int limit, String query, String status) async {
    Filter filter = Filter(query: query, status: status);
    Offset offset = Offset(limit: limit, page: page);
    if (user.currentBusiness?.type == "BUYER") {
      invoice = await InvoiceApi()
          .listReceived(ResultArguments(filter: filter, offset: offset));
    } else {
      invoice = await InvoiceApi()
          .list(ResultArguments(filter: filter, offset: offset));
    }
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

  groupMaker() {
    List<Invoice> group = [];
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
      group.add(Invoice(
        header: key,
        values: value,
      ));
    });
    groupedList = group;
  }

  @override
  void initState() {
    listenController.addListener(() {
      setState(() {
        isLoading = true;
      });
      list(page, limit, '', selectedStatus!);
    });
    super.initState();
  }

  onChange(String query) async {
    if (timer != null) timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        isLoading = true;
        startAnimation = false;
        groupItems = {};
      });
      await list(page, limit, query, selectedStatus!);
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).invoiceMe;
    general =
        Provider.of<GeneralProvider>(context, listen: true).invoiceGeneral;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Нээлттэй нэхэмжлэх',
          style: TextStyle(
            fontSize: 17,
            color: invoiceColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: invoiceColor,
          ),
        ),
        actions: [
          if (user.currentBusiness?.type == "SUPPLIER")
            AddButton(
              color: invoiceColor,
              onClick: () {
                Navigator.of(context).pushNamed(
                  NewInvoice.routeName,
                  arguments: NewInvoiceArguments(data: null),
                );
              },
            )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            color: white,
            height: 50,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              itemCount: general.invoiceStatus?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: selectedStatus != general.invoiceStatus?[index].code
                      ? () {
                          setState(() {
                            selectedStatus = general.invoiceStatus?[index].code;
                            isLoading = true;
                            page = 1;
                            groupItems = {};
                          });
                          list(page, limit, search, selectedStatus!);
                        }
                      : () {},
                  child: Container(
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color:
                          selectedStatus == general.invoiceStatus?[index].code
                              ? invoiceColor
                              : Colors.grey.shade100,
                    ),
                    child: Center(
                      child: Text(
                        '${general.invoiceStatus?[index].name}',
                        style: TextStyle(
                          fontSize: 12,
                          color: selectedStatus ==
                                  general.invoiceStatus?[index].code
                              ? white
                              : grey2,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SearchButton(
            onChange: (query) {
              setState(() {
                search = query;
              });
              onChange(query);
            },
            color: invoiceColor,
          ),
          isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: invoiceColor,
                  ),
                )
              : Expanded(
                  child: Refresher(
                    refreshController: _refreshController,
                    onLoading: invoice.rows!.length == invoice.count
                        ? null
                        : _onLoading,
                    onRefresh: _onRefresh,
                    color: invoiceColor,
                    child: SingleChildScrollView(
                      child: groupedList.isEmpty
                          ? const NotFound(
                              module: "INVOICE",
                              labelText: "Нэхэмжлэл олдсонгүй",
                            )
                          : Column(
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
                                              left: 15, top: 10, bottom: 10),
                                          child: Text(
                                            DateFormat('yyyy-MM-dd')
                                                .format(item.header!),
                                            style: const TextStyle(
                                              color: grey3,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: item.values!
                                              .map(
                                                (data) => Column(
                                                  children: [
                                                    InvoiceCard(
                                                      startAnimation:
                                                          startAnimation,
                                                      index: invoice.rows!
                                                          .indexOf(data),
                                                      data: data,
                                                      onClick: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                          InvoiceDetailPage
                                                              .routeName,
                                                          arguments:
                                                              InvoiceDetailPageArguments(
                                                            id: data.id!,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
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
}
