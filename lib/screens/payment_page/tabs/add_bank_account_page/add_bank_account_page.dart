import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/bank_account_card/bank_account_card.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/account_statement/account_statement.dart';
import 'package:dehub/screens/bank_account_detail/bank_account_detail.dart';
import 'package:dehub/screens/transaction_history/transaction_history.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddBankAccountPage extends StatefulWidget {
  static const routeName = '/addbankaccountpage';
  const AddBankAccountPage({Key? key}) : super(key: key);

  @override
  _AddBankAccountPageState createState() => _AddBankAccountPageState();
}

User user = User();

class _AddBankAccountPageState extends State<AddBankAccountPage>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result payment = Result(rows: [], count: 0);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ListenController listenController = ListenController();

  list(page, limit) async {
    Filter filter = Filter(query: '');
    Offset offset = Offset(page: page, limit: limit);
    var res = await PaymentApi()
        .bankAccountList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      payment = res;
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
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
  void initState() {
    listenController.addListener(() {
      list(page, limit);
    });
    super.initState();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(color: paymentColor),
            )
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: refreshController,
              header: WaterDropHeader(
                waterDropColor: paymentColor,
                refresh: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: paymentColor,
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
              child: payment.rows?.length != 0
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    'Холбосон данснууд',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Column(
                                  children: payment.rows!
                                      .map(
                                        (data) => Column(
                                          children: [
                                            BankAccountCard(
                                              transactionClick: () {
                                                Navigator.of(context).pushNamed(
                                                  TransactionHistory.routeName,
                                                  arguments:
                                                      TransactionHistoryArguments(
                                                    data: data,
                                                  ),
                                                );
                                              },
                                              data: data,
                                              onClick: () {
                                                Navigator.of(context).pushNamed(
                                                  BankAccountDetail.routeName,
                                                  arguments:
                                                      BankAccountDetailArguments(
                                                    id: data.id,
                                                  ),
                                                );
                                              },
                                              statementClick: () {
                                                Navigator.of(context).pushNamed(
                                                  AccountStatement.routeName,
                                                  arguments:
                                                      AccountStatementArguments(
                                                    data: data,
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : NotFound(
                      module: "PAYMENT",
                      labelText:
                          'Та данс холбоогүй байна. "+" сонгож дансаа холбоно уу',
                      textColor: grey2,
                    ),
            ),
    );
  }
}
