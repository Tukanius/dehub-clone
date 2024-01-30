import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/repayment_detail/tabs/basic_information.dart';
import 'package:dehub/src/finance_module/screens/repayment_detail/tabs/compromises_tab.dart';
import 'package:dehub/src/finance_module/screens/repayment_detail/tabs/email_reminder_tab.dart';
import 'package:dehub/src/finance_module/screens/repayment_detail/tabs/payment_history_tab.dart';
import 'package:dehub/src/finance_module/screens/repayment_detail/tabs/reminder_history_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class RePaymentDetailArguments {
  String id;
  RePaymentDetailArguments({
    required this.id,
  });
}

class RePaymentDetail extends StatefulWidget {
  final String id;
  static const routeName = '/RePaymentDetail';
  const RePaymentDetail({
    super.key,
    required this.id,
  });

  @override
  State<RePaymentDetail> createState() => _RePaymentDetailState();
}

class _RePaymentDetailState extends State<RePaymentDetail>
    with AfterLayoutMixin {
  Finance get = Finance();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    get = await FinanceApi().repaymentGet(source.url, widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          surfaceTintColor: backgroundColor,
          leadingWidth: 100,
          leading: CustomBackButton(color: source.currentColor),
          elevation: 0,
        ),
        body: Column(
          children: [
            Material(
              color: white,
              elevation: 2,
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
                unselectedLabelColor: buttonColor,
                indicatorColor: source.currentColor,
                labelColor: source.currentColor,
                tabs: const [
                  Tab(text: 'Үндсэн мэдээлэл'),
                  Tab(text: 'Төлөлтийн түүх'),
                  Tab(text: 'Сануулга түүх'),
                  Tab(text: 'И-мэйл сануулга'),
                  Tab(text: 'Амлалтууд'),
                ],
              ),
            ),
            Expanded(
              child: isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: source.currentColor,
                      ),
                    )
                  : TabBarView(
                      children: [
                        BasicInformation(
                          data: get,
                        ),
                        PaymentHistoryTab(
                          id: widget.id,
                        ),
                        ReminderHistoryTab(
                          id: widget.id,
                        ),
                        EmailReminderTab(
                          id: widget.id,
                        ),
                        CompromisesTab(
                          id: widget.id,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
