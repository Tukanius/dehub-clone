import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/partner_cards/partner_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/partner_page/partner_detail_page/partner_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class NetworkPartnerPage extends StatefulWidget {
  static const routeName = '/NetworkPartnerPage';
  const NetworkPartnerPage({super.key});

  @override
  State<NetworkPartnerPage> createState() => _NetworkPartnerPageState();
}

class _NetworkPartnerPageState extends State<NetworkPartnerPage>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result businessNetwork = Result(count: 0, rows: []);
  bool isLoading = true;
  bool startAnimation = false;

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit);
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '');
    Result res = await BusinessApi().networkList(
      ResultArguments(offset: offset, filter: filter),
    );
    setState(() {
      businessNetwork = res;
      isLoading = false;
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leadingWidth: 100,
        leading: CustomBackButton(color: networkColor),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: networkColor,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15, top: 5),
                      child: Text(
                        'Харилцагч',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    businessNetwork.rows?.length != 0
                        ? Column(
                            children: businessNetwork.rows!
                                .map(
                                  (e) => PartnerCard(
                                    index: businessNetwork.rows!.indexOf(e),
                                    startAnimation: startAnimation,
                                    data: e,
                                    onClick: () {
                                      Navigator.of(context).pushNamed(
                                        PartnerDetailPage.routeName,
                                        arguments: PartnerDetailPageArguments(
                                          id: e.id,
                                        ),
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          )
                        : NotFound(
                            module: 'NETWORK',
                            labelText: "Харилцагч олдсонгүй",
                          )
                  ],
                ),
              ),
            ),
    );
  }
}
