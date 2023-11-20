import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/components/network_horizontal_chart/network_horizontal_chart.dart';
import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/models/business.dart';
import 'package:dehub/src/network_module/screens/account_setting/account_setting.dart';
import 'package:dehub/src/network_module/screens/client_classifications/client_classifications.dart';
import 'package:dehub/src/network_module/screens/distribution_areas/distribution_areas.dart';
import 'package:dehub/src/network_module/screens/reference_information_page/reference_information_page.dart';
import 'package:dehub/src/network_module/screens/partner_page/partner_page.dart';
import 'package:dehub/src/network_module/screens/client_staffs/client_staffs.dart';
import 'package:dehub/src/network_module/screens/payment_terms/payment_terms.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardTabState createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> with AfterLayoutMixin {
  bool isLoading = true;
  Business received = Business();
  Business sent = Business();
  Map<String, dynamic> pieChart = {};
  Map<String, double> data = {};
  List<Business> legend = [];

  @override
  afterFirstLayout(BuildContext context) async {
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: Text(
              'Дашбоард',
              style: TextStyle(
                  color: black, fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
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
                DashboardCard(
                  onClick: () {
                    Navigator.of(context).pushNamed(ClientStaffs.routeName);
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
                    Navigator.of(context).pushNamed(PaymentTerms.routeName);
                  },
                  boxColor: networkColor.withOpacity(0.1),
                  padding: 8,
                  labelText: 'Төлбөрийн нөхцөл',
                  svgColor: networkColor,
                  svg: 'assets/svg/payment-term.svg',
                ),
                DashboardCard(
                  onClick: () {
                    Navigator.of(context).pushNamed(AccountSetting.routeName);
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
                DashboardCard(
                  onClick: () {
                    Navigator.of(context)
                        .pushNamed(ReferenceInformationPage.routeName);
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
          SizedBox(
            height: 25,
          ),
          isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: networkColor,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    data.isNotEmpty
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: Text(
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Row(
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
                              SizedBox(
                                height: 10,
                              ),
                              PieChart(
                                legend: legend,
                                colorList: colorList,
                                data: data,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        : SizedBox(),
                    received.stats != null
                        ? NetworkHorizontalChart(
                            index: 2,
                            data: received,
                            labelText: 'Танайд ирсэн',
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 10,
                    ),
                    sent.stats != null
                        ? NetworkHorizontalChart(
                            index: 3,
                            labelText: 'Танай илгээсэн',
                            data: sent,
                          )
                        : SizedBox(),
                  ],
                ),
        ],
      ),
    );
  }
}
