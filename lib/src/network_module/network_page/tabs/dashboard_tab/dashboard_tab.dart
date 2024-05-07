import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/network_module/screens/reference_information_page/reference_information_page.dart';
import 'package:dehub/src/network_module/screens/client_classifications/client_classifications.dart';
import 'package:dehub/src/network_module/screens/distribution_areas/distribution_areas.dart';
import 'package:dehub/src/network_module/components/network_horizontal_chart/network_horizontal_chart.dart';
import 'package:dehub/src/network_module/screens/account_setting/account_setting.dart';
import 'package:dehub/src/network_module/screens/client_staffs/client_staffs.dart';
import 'package:dehub/src/network_module/screens/payment_terms/payment_terms.dart';
import 'package:dehub/src/network_module/screens/partner_page/partner_page.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/business_api.dart';
import 'package:dehub/models/business.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({
    super.key,
  });

  @override
  DashboardTabState createState() => DashboardTabState();
}

class DashboardTabState extends State<DashboardTab> with AfterLayoutMixin {
  bool isLoading = true;
  Business received = Business();
  Business sent = Business();
  Map<String, dynamic> pieChart = {};
  Map<String, double> data = {};
  List<Business> legend = [];
  User user = User();

  @override
  afterFirstLayout(BuildContext context) async {
    if (Permission().check(user, "NET_DASH")) {
      pieChart = await BusinessApi().pieChart();
      Map<String, double> pieData = {};
      pieChart.forEach((key, value) {
        pieData[key] = double.parse(value.toString());
        legend.add(
          Business(
            count: value,
            profileName: key,
          ),
        );
      });
      setState(() {
        data = pieData;
      });
      received = await BusinessApi().dashboardReceived();
      sent = await BusinessApi().dashboardSent();
    }
    setState(() {
      isLoading = false;
    });
  }

  final colorList = <Color>[
    networkColor,
    networkDashboard1,
    networkDashboard2,
    networkDashboard3,
    networkDashboard4,
  ];

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).businessUser;
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsSCrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  child: const Text(
                    'Дашбоард',
                    style: TextStyle(
                        color: black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                if (Permission().check(user, "NET_LIST"))
                  SizedBox(
                    height: 100,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      children: [
                        DashboardCard(
                          onClick: () {
                            Navigator.of(context)
                                .pushNamed(NetworkPartnerPage.routeName);
                          },
                          boxColor: networkColor.withOpacity(0.1),
                          padding: 10,
                          labelText: 'Манай харилцагч',
                          svgColor: networkColor,
                          svg: 'assets/svg/partners.svg',
                        ),
                        if (Permission().check(user, "NET_STF"))
                          DashboardCard(
                            onClick: () {
                              Navigator.of(context)
                                  .pushNamed(ClientStaffs.routeName);
                            },
                            boxColor: networkColor.withOpacity(0.1),
                            padding: 9,
                            labelText: 'Хариуцсан ажилтан',
                            svgColor: networkColor,
                            svg: 'assets/svg/double-person.svg',
                          ),
                        DashboardCard(
                          onClick: () {
                            Navigator.of(context)
                                .pushNamed(ClientClassifications.routeName);
                          },
                          boxColor: networkColor.withOpacity(0.1),
                          padding: 9,
                          labelText: 'Ангилал, зэрэглэл',
                          svgColor: networkColor,
                          svg: 'assets/svg/double-person.svg',
                        ),
                        DashboardCard(
                          onClick: () {
                            Navigator.of(context)
                                .pushNamed(PaymentTerms.routeName);
                          },
                          boxColor: networkColor.withOpacity(0.1),
                          padding: 8,
                          labelText: 'Төлбөрийн нөхцөл',
                          svgColor: networkColor,
                          svg: 'assets/svg/payment-term.svg',
                        ),
                        DashboardCard(
                          onClick: () {
                            Navigator.of(context)
                                .pushNamed(AccountSetting.routeName);
                          },
                          boxColor: networkColor.withOpacity(0.1),
                          padding: 9,
                          labelText: 'Данс тохиргоо',
                          svgColor: networkColor,
                          svg: 'assets/svg/wallet.svg',
                        ),
                        DashboardCard(
                          onClick: () {
                            Navigator.of(context)
                                .pushNamed(DistributionAreas.routeName);
                          },
                          boxColor: networkColor.withOpacity(0.1),
                          padding: 10,
                          labelText: 'Чиглэл, бүсчлэл',
                          svgColor: networkColor,
                          svg: 'assets/svg/map.svg',
                        ),
                        if (user.currentBusiness?.type == "SUPPLIER")
                          DashboardCard(
                            onClick: () {
                              Navigator.of(context).pushNamed(
                                  ReferenceInformationPage.routeName);
                            },
                            boxColor: networkColor.withOpacity(0.1),
                            padding: 7,
                            labelText: 'Лавлах мэдээлэл',
                            svgColor: networkColor,
                            svg: 'assets/svg/bag.svg',
                          ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ];
      },
      body: Permission().check(user, "NET_DASH")
          ? isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: networkColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (data.isNotEmpty)
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  child: const Text(
                                    'Харилцагч бизнесүүд',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        NetworkPartnerPage.routeName);
                                  },
                                  child: Container(
                                    color: transparent,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: const Row(
                                      children: [
                                        Text(
                                          "Бүгдийг",
                                          style: TextStyle(
                                            color: networkColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: networkColor,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            PieChart(
                              legend: legend,
                              colorList: colorList,
                              data: data,
                              module: "NETWORK",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      if (received.stats != null)
                        NetworkHorizontalChart(
                          index: 2,
                          data: received,
                          labelText: 'Танайд ирсэн',
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (sent.stats != null)
                        NetworkHorizontalChart(
                          index: 3,
                          labelText: 'Танай илгээсэн',
                          data: sent,
                        ),
                    ],
                  ),
                )
          : const NotFound(
              module: 'NETWORK',
              labelText: 'Хандах эрх хүрэлцэхгүй байна',
            ),
    );
  }
}
