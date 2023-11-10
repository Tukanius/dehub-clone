import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/screens/received_funding_page/tabs1/b_decision_tab.dart';
import 'package:dehub/screens/received_funding_page/tabs1/main_info_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class GiveFundingDetailPage extends StatefulWidget {
  static const routeName = '/GiveFundingDetailPage';
  const GiveFundingDetailPage({Key? key}) : super(key: key);

  @override
  State<GiveFundingDetailPage> createState() => _GiveFundingDetailPageState();
}

class _GiveFundingDetailPageState extends State<GiveFundingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 200,
        leading: CustomBackButton(color: financingColor),
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
              MainInfoTab(),
              BDecisionTab(),
            ],
          ),
        ),
      ),
    );
  }
}
