import 'package:dehub/src/network_module/screens/partner_page/partner_detail_page/tabs/information_tab.dart';
import 'package:dehub/src/network_module/screens/partner_page/partner_detail_page/tabs/sector_tab.dart';
import 'package:dehub/src/network_module/screens/partner_page/partner_detail_page/tabs/staffs_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dehub/models/business_network.dart';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/business_api.dart';
import 'package:flutter/material.dart';

class PartnerDetailPageArguments {
  String id;
  PartnerDetailPageArguments({
    required this.id,
  });
}

class PartnerDetailPage extends StatefulWidget {
  final String id;
  static const routeName = '/PartnerDetailPage';
  const PartnerDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<PartnerDetailPage> createState() => _PartnerDetailPageState();
}

class _PartnerDetailPageState extends State<PartnerDetailPage>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  BusinessNetwork businessNetwork = BusinessNetwork();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    businessNetwork = await BusinessApi().networkGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: networkColor),
        title: const Text(
          'Харилцагч бизнес',
          style: TextStyle(
            color: networkColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: networkColor,
              ),
            )
          : DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          if (businessNetwork.profileBanners!.isNotEmpty)
                            CarouselSlider(
                              items: businessNetwork.profileBanners!
                                  .map(
                                    (data) => Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: white,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            '${data.url}',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              options: CarouselOptions(
                                enlargeCenterPage:
                                    businessNetwork.profileBanners?.length != 1,
                                autoPlayCurve: Curves.ease,
                                height: 200,
                                autoPlay:
                                    businessNetwork.profileBanners?.length != 1,
                                enableInfiniteScroll:
                                    businessNetwork.profileBanners?.length != 1,
                              ),
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          Material(
                            color: white,
                            child: TabBar(
                              overlayColor: MaterialStatePropertyAll(
                                  Colors.grey.shade100),
                              indicatorColor: networkColor,
                              labelColor: networkColor,
                              unselectedLabelColor: dark,
                              tabs: const [
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text('Мэдээлэл'),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text('Ажилтан'),
                                  ),
                                ),
                                SizedBox(
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
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    InformationTab(
                      data: businessNetwork,
                    ),
                    StaffsTab(
                      staffs: businessNetwork.staffs,
                    ),
                    SectorTab(
                      data: businessNetwork.branches,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
