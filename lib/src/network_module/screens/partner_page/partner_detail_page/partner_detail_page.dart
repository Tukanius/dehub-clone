import 'package:dehub/components/full_picture/full_picture.dart';
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
  BusinessNetwork partner = BusinessNetwork();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    partner = await BusinessApi().networkGet(widget.id);
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
                          if (partner.profileBanners!.isNotEmpty)
                            CarouselSlider(
                              items: partner.profileBanners!.map((data) {
                                List<String> images = [];
                                for (var data in partner.profileBanners!) {
                                  images.add(data.url!);
                                }
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      FullPicture.routeName,
                                      arguments: FullPictureArguments(
                                        pictures: images,
                                        initialPage: partner.profileBanners!
                                            .indexOf(data),
                                      ),
                                    );
                                  },
                                  child: Container(
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
                                );
                              }).toList(),
                              options: CarouselOptions(
                                enlargeCenterPage:
                                    partner.profileBanners?.length != 1,
                                autoPlayCurve: Curves.ease,
                                height: 200,
                                autoPlay: partner.profileBanners?.length != 1,
                                enableInfiniteScroll:
                                    partner.profileBanners?.length != 1,
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
                      data: partner,
                    ),
                    StaffsTab(
                      staffs: partner.staffs,
                    ),
                    SectorTab(
                      data: partner.branches,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
