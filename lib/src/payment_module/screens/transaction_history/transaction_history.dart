import 'package:dehub/components/transaction_filter_card/transaction_filter_card.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/transaction_information_card/transaction_information_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/payment_module/screens/transaction_detail_page/transaction_detail_page.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionHistoryArguments {
  Payment data;
  TransactionHistoryArguments({
    required this.data,
  });
}

class TransactionHistory extends StatefulWidget {
  final Payment data;
  static const routeName = '/TransactionHistory';
  const TransactionHistory({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  List<Payment> groupedList = [];
  Map<DateTime, List<Payment>> groupItems = {};
  DateTimeRange dateTimeRange = DateTimeRange(
    start: DateTime.now().subtract(Duration(days: 1)),
    end: DateTime.now(),
  );
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int currentIndex = 0;
  List<String> filter = ['ALL', 'DEBIT', "CREDIT"];
  String? filterText = 'ALL';
  Result transaction = Result();
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  bool startAnimation = false;

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit, "ALL", dateTimeRange.start.toString(),
        dateTimeRange.end.toString());
  }

  list(page, limit, String inOutType, String startDate, String endDate) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(
      inOutType: "${inOutType}",
      accountId: widget.data.id,
      startDate: startDate,
      endDate: endDate,
    );
    transaction = await PaymentApi()
        .transactionList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
    await groupMaker();
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
    await list(page, limit, '${filterText}', dateTimeRange.start.toString(),
        dateTimeRange.end.toString());
    _refreshController.loadComplete();
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
    await list(page, limit, '${filterText}', dateTimeRange.start.toString(),
        dateTimeRange.end.toString());
    _refreshController.refreshCompleted();
    setState(() {
      isLoading = false;
    });
  }

  groupMaker() {
    List<Payment> group = [];
    for (var data in transaction.rows!) {
      DateTime createdAt =
          DateTime.parse(DateFormat('yyyy-MM-dd').format(data.createdAt));
      if (groupItems.containsKey(createdAt)) {
        groupItems[createdAt]!.add(data);
      } else {
        groupItems[createdAt] = [data];
      }
    }
    groupItems.forEach((key, value) {
      group.add(
        Payment(
          header: key,
          values: value,
        ),
      );
    });
    groupedList = group;
  }

  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: paymentColor,
          ),
        ),
        title: Text(
          'Гүйлгээний түүх',
          style: TextStyle(color: paymentColor, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              '${widget.data.number}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: paymentColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '${widget.data.bankName}',
              style: TextStyle(fontSize: 15, color: grey2),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              pickDateRange();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: grey2.withOpacity(0.5), width: 0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${start.year} - ${start.month} - ${start.day}',
                    style: TextStyle(color: grey2),
                  ),
                  SvgPicture.asset('assets/svg/calendar.svg'),
                  Icon(
                    Icons.arrow_forward,
                    size: 15,
                    color: paymentColor,
                  ),
                  Text(
                    '${end.year} - ${end.month} - ${end.day}',
                    style: TextStyle(color: grey2),
                  ),
                  SvgPicture.asset('assets/svg/calendar.svg')
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: filter
                .map(
                  (item) => TransactionFilterCard(
                    onClick: () {
                      setState(() {
                        filterText = item;
                        isLoading = true;
                        groupItems = {};
                      });
                      list(page, limit, "${filterText}", start.toString(),
                          end.toString());
                    },
                    isTap: item == filterText,
                    text: item == "ALL"
                        ? 'Бүгд'
                        : item == "DEBIT"
                            ? "Орлого"
                            : "Зарлага",
                  ),
                )
                .toList(),
          ),
          isLoading == true
              ? Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: paymentColor,
                    ),
                  ),
                )
              : groupedList.length != 0
                  ? Expanded(
                      child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          controller: _refreshController,
                          header: WaterDropHeader(
                            waterDropColor: networkColor,
                            refresh: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: networkColor,
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
                                body =
                                    const Text("Алдаа гарлаа. Дахин үзнэ үү!");
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
                                    (data) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AnimatedContainer(
                                          transform: Matrix4.translationValues(
                                              startAnimation
                                                  ? 0
                                                  : MediaQuery.of(context)
                                                      .size
                                                      .width,
                                              0,
                                              0),
                                          curve: Curves.ease,
                                          duration: Duration(
                                              milliseconds: 200 +
                                                  (groupedList.indexOf(data) +
                                                      200)),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child: Text(
                                            '${DateFormat("yyyy-MM-dd").format(data.header!)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: grey2,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: data.values!
                                              .map(
                                                (item) =>
                                                    TransactionInformationCard(
                                                  index: (data.values!
                                                          .indexOf(item) +
                                                      groupedList
                                                          .indexOf(data) +
                                                      1),
                                                  startAnimation:
                                                      startAnimation,
                                                  onClick: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                      TransactionDetailPage
                                                          .routeName,
                                                      arguments:
                                                          TransactionDetailPageArguments(
                                                        data: item,
                                                      ),
                                                    );
                                                  },
                                                  data: item,
                                                ),
                                              )
                                              .toList(),
                                        )
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          )),
                    )
                  : NotFound(
                      module: "PAYMENT",
                      labelText: "Гүйлгээний түүх хоосон байна",
                    ),
        ],
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      saveText: 'Хадгалах',
      builder: (BuildContext context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: paymentColor,
              onPrimary: Colors.white,
              onSurface: paymentColor,
            ),
          ),
          child: child!,
        );
      },
      errorFormatText: 'Сүүлийн 6-н сар сонгоно уу!!!',
      context: context,
      initialDateRange: dateTimeRange,
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now(),
    );

    if (newDateRange == null) return;
    setState(() {
      dateTimeRange = newDateRange;
      isLoading = true;
    });
    setState(() {
      startAnimation = false;
    });
    list(page, limit, '${filterText}', dateTimeRange.start.toString(),
        dateTimeRange.end.toString());
  }
}
