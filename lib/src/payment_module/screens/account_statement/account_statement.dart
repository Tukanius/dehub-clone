import 'package:dehub/models/payment.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/transaction_information_card/transaction_information_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/payment_module/screens/transaction_detail_page/transaction_detail_page.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';

class AccountStatementArguments {
  Payment data;
  AccountStatementArguments({
    required this.data,
  });
}

class AccountStatement extends StatefulWidget {
  final Payment data;
  static const routeName = '/AccountStatement';
  const AccountStatement({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _AccountStatementState createState() => _AccountStatementState();
}

class _AccountStatementState extends State<AccountStatement>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  DateTimeRange dateTimeRange = DateTimeRange(
    start: DateTime.now().subtract(Duration(days: 1)),
    end: DateTime.now(),
  );
  int currentIndex = 0;
  Result transaction = Result();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) {
    list("ALL", dateTimeRange.start.toString(), dateTimeRange.end.toString());
  }

  list(String inOutType, String startDate, String endDate) async {
    Offset offset = Offset(page: 0, limit: 0);
    Filter filter = Filter(
      inOutType: "${inOutType}",
      accountId: widget.data.id,
      startDate: startDate,
      endDate: endDate,
    );
    var res = await PaymentApi()
        .accountStatement(ResultArguments(filter: filter, offset: offset));
    setState(() {
      transaction = res;
      isLoading = false;
    });
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
          'Дансны хуулга',
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
          isLoading == true
              ? Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: paymentColor,
                    ),
                  ),
                )
              : transaction.rows?.length != 0
                  ? SingleChildScrollView(
                      child: Column(
                        children: transaction.rows!
                            .map(
                              (data) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Text(
                                        '${DateFormat("yyyy-MM-dd").format(data.createdAt)}'),
                                  ),
                                  TransactionInformationCard(
                                    startAnimation: true,
                                    index: 0,
                                    onClick: () {
                                      Navigator.of(context).pushNamed(
                                        TransactionDetailPage.routeName,
                                        arguments:
                                            TransactionDetailPageArguments(
                                          data: data,
                                        ),
                                      );
                                    },
                                    data: data,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : NotFound(
                      module: "PAYMENT",
                      labelText: "Дансны хуулга хоосон байна",
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
  }
}