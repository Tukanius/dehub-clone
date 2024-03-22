import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/finance_api.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/account_detail_page/tabs/account_information.dart';
import 'package:dehub/src/finance_module/screens/account_detail_page/tabs/payment_history.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountDetailPageArguments {
  String id;
  AccountDetailPageArguments({
    required this.id,
  });
}

class AccountDetailPage extends StatefulWidget {
  static const routeName = '/AccountDetailPage';
  final String id;
  const AccountDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage>
    with AfterLayoutMixin {
  Finance finance = Finance(payments: []);
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    finance = await FinanceApi().requestGet(source.url, widget.id, 'lbf');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: source.currentColor),
          backgroundColor: white,
          surfaceTintColor: white,
          title: Text(
            'Зээлийн дансны мэдээлэл',
            style: TextStyle(
              color: source.currentColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: TabBar(
            indicatorColor: source.currentColor,
            labelColor: source.currentColor,
            unselectedLabelColor: grey2,
            overlayColor: MaterialStatePropertyAll(Colors.grey.shade200),
            tabs: const [
              Tab(
                text: 'Дансны мэдээлэл',
              ),
              Tab(
                text: 'Төлөлтийн түүх',
              ),
            ],
          ),
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: source.currentColor,
                ),
              )
            : TabBarView(
                children: [
                  AccountInformation(
                    data: finance,
                  ),
                  PaymentHistory(
                    data: finance.payments!,
                    currency: finance.currency!,
                  ),
                ],
              ),
      ),
    );
  }
}
