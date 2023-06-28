import 'package:dehub/screens/received_funding_page/tabs/bank_decision_tab.dart';
import 'package:dehub/screens/received_funding_page/tabs/main_information.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ReceivedFundingDetailPage extends StatefulWidget {
  static const routeName = '/ReceivedFundingDetailPage';
  const ReceivedFundingDetailPage({super.key});

  @override
  State<ReceivedFundingDetailPage> createState() =>
      _ReceivedFundingDetailPageState();
}

class _ReceivedFundingDetailPageState extends State<ReceivedFundingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 200,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.arrow_back_ios_new,
                color: financingColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Буцах',
                style: TextStyle(
                  color: financingColor,
                  fontSize: 17,
                ),
              )
            ],
          ),
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
                    indicatorColor: financingColor,
                    labelColor: financingColor,
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
          body: TabBarView(
            children: [
              MainInformationTab(),
              BankDecisionTab(),
            ],
          ),
        ),
      ),
    );
  }
}
