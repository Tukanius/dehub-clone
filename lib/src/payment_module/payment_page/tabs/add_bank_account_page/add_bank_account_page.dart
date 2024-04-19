import 'package:dehub/api/payment_api.dart';
import 'package:dehub/src/payment_module/components/bank_account_card/bank_account_card.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/payment_module/screens/account_statement/account_statement.dart';
import 'package:dehub/src/payment_module/screens/bank_account_detail/bank_account_detail.dart';
import 'package:dehub/src/payment_module/screens/transaction_history/transaction_history.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddBankAccountPage extends StatefulWidget {
  static const routeName = '/addbankaccountpage';
  const AddBankAccountPage({super.key});

  @override
  AddBankAccountPageState createState() => AddBankAccountPageState();
}

class AddBankAccountPageState extends State<AddBankAccountPage>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result payment = Result(rows: [], count: 0);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ListenController listenController = ListenController();
  User user = User();

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
  afterFirstLayout(BuildContext context) async {
    if (Permission().check(user, "PAY_ACC")) {
      await list(page, limit);
    }
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
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

  void onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).paymentMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Permission().check(user, "ORD_SPLIT")
          ? isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(color: paymentColor),
                )
              : Refresher(
                  refreshController: refreshController,
                  onLoading:
                      payment.rows!.length == payment.count ? null : onLoading,
                  onRefresh: onRefresh,
                  color: paymentColor,
                  child: payment.rows!.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: const Text(
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
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                      TransactionHistory
                                                          .routeName,
                                                      arguments:
                                                          TransactionHistoryArguments(
                                                        data: data,
                                                      ),
                                                    );
                                                  },
                                                  data: data,
                                                  onClick: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                      BankAccountDetail
                                                          .routeName,
                                                      arguments:
                                                          BankAccountDetailArguments(
                                                        id: data.id,
                                                      ),
                                                    );
                                                  },
                                                  statementClick: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                      AccountStatement
                                                          .routeName,
                                                      arguments:
                                                          AccountStatementArguments(
                                                        data: data,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : const NotFound(
                          module: "PAYMENT",
                          labelText:
                              'Та данс холбоогүй байна. "+" сонгож дансаа холбоно уу',
                          textColor: grey2,
                        ),
                )
          : const NotFound(
              module: "PAYMENT",
              labelText: "Хандах эрх хүрэлцэхгүй байна",
            ),
    );
  }
}
