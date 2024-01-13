import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/received_funding_detail/tabs/bank_decision_tab.dart';
import 'package:dehub/src/finance_module/screens/received_funding_detail/tabs/main_information.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class ReceivedFundingDetailPageArguments {
  String id;
  ReceivedFundingDetailPageArguments({
    required this.id,
  });
}

class ReceivedFundingDetailPage extends StatefulWidget {
  final String id;
  static const routeName = '/ReceivedFundingDetailPage';
  const ReceivedFundingDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ReceivedFundingDetailPage> createState() =>
      _ReceivedFundingDetailPageState();
}

class _ReceivedFundingDetailPageState extends State<ReceivedFundingDetailPage>
    with AfterLayoutMixin {
  Finance get = Finance();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    get = await FinanceApi().requestGet(source.url, widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        elevation: 0,
        leadingWidth: 200,
        leading: CustomBackButton(
          color: source.currentColor,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Material(
                  color: white,
                  elevation: 2,
                  child: TabBar(
                    overlayColor:
                        MaterialStatePropertyAll(Colors.grey.shade100),
                    indicatorColor: source.currentColor,
                    labelColor: source.currentColor,
                    unselectedLabelColor: grey2,
                    tabs: [
                      Container(
                        height: 40,
                        child: Center(
                          child: Text('Үндсэн мэдээлэл'),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: Center(
                          child: Text('Банкны шийдвэр'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: source.currentColor,
                  ),
                )
              : TabBarView(
                  children: [
                    MainInformationTab(
                      data: get,
                    ),
                    BankDecisionTab(
                      data: get,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
