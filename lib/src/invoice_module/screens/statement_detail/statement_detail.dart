import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/src/invoice_module/screens/statement_detail/tabs/closed_tab.dart';
import 'package:dehub/src/invoice_module/screens/statement_detail/tabs/pending_tab.dart';
import 'package:dehub/src/invoice_module/screens/statement_detail/tabs/open_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class StatementDetailArguments {
  Invoice data;
  StatementDetailArguments({
    required this.data,
  });
}

class StatementDetail extends StatefulWidget {
  static const routeName = '/StatementDetail';
  final Invoice data;
  const StatementDetail({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<StatementDetail> createState() => _StatementDetailState();
}

class _StatementDetailState extends State<StatementDetail> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 3,
          backgroundColor: white,
          leading: CustomBackButton(
            color: invoiceColor,
          ),
          leadingWidth: 130,
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            unselectedLabelStyle:
                TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            labelColor: invoiceColor,
            indicatorColor: invoiceColor,
            unselectedLabelColor: grey2,
            tabs: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('Нээлттэй'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('Батлах'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('Хаагдсан'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OpenTab(
              data: widget.data,
            ),
            PendingTab(
              data: widget.data,
            ),
            ClosedTab(
              data: widget.data,
            ),
          ],
        ),
      ),
    );
  }
}
