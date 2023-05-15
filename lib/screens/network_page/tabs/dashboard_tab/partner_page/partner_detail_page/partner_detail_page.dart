import 'package:dehub/components/partner_cards/partner_card.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/partner_page/partner_detail_page/tabs/information_tab.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/partner_page/partner_detail_page/tabs/sector_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class PartnerDetailPage extends StatefulWidget {
  static const routeName = 'PartnerDetailPage';
  const PartnerDetailPage({super.key});

  @override
  State<PartnerDetailPage> createState() => _PartnerDetailPageState();
}

class _PartnerDetailPageState extends State<PartnerDetailPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: networkColor,
          ),
        ),
        title: Text(
          'Харилцагч бизнес',
          style: TextStyle(
            color: networkColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image(
                        image: AssetImage('images/map.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    PartnerCard(
                      type: false,
                    ),
                    Container(
                      color: white,
                      child: TabBar(
                        indicatorColor: networkColor,
                        labelColor: networkColor,
                        unselectedLabelColor: dark,
                        tabs: [
                          Container(
                            height: 40,
                            child: Center(
                              child: Text('Мэдээлэл'),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Center(
                              child: Text('Ажилтан'),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Center(
                              child: Text('Салбар'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              InformationTab(),
              Text('1'),
              SectorTab(),
            ],
          ),
        ),
      ),
    );
  }
}
