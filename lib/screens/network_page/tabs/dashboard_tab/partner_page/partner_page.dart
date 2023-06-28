import 'package:dehub/api/business_api.dart';
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

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter();
    Result res = await BusinessApi().networkList(
      ResultArguments(offset: offset, filter: filter),
    );
    setState(() {
      businessNetwork = res;
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
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_new,
                color: networkColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Буцах',
                style: TextStyle(color: networkColor, fontSize: 17),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 5),
                child: Text(
                  'Харилцагч',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: businessNetwork.rows!
                    .map(
                      (e) => PartnerCard(
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
            ],
          ),
        ),
      ),
    );
  }
}
