import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/network_horizontal_chart/network_horizontal_chart.dart';
import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/models/business.dart';
import 'package:dehub/screens/account_setting/account_setting.dart';
import 'package:dehub/screens/client_classifications/client_classifications.dart';
import 'package:dehub/screens/distribution_areas/distribution_areas.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/reference_information_page/reference_information_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/partner_page/partner_page.dart';
import 'package:dehub/screens/client_staffs/client_staffs.dart';
import 'package:dehub/screens/payment_terms/payment_terms.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(NetworkPartnerPage.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    padding: const EdgeInsets.all(8),
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: networkColor.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/partners.svg',
                            colorFilter:
                                ColorFilter.mode(networkColor, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Манай харилцагч',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ClientStaffs.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    padding: const EdgeInsets.all(8),
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: networkColor.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/double-person.svg',
                            colorFilter:
                                ColorFilter.mode(networkColor, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Хариуцсан ажилтан',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ClientClassifications.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    padding: const EdgeInsets.all(8),
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: networkColor.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/double-person.svg',
                            colorFilter:
                                ColorFilter.mode(networkColor, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Ангилал, зэрэглэл',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(PaymentTerms.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    padding: const EdgeInsets.all(8),
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: networkColor.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/payment-term.svg',
                            colorFilter:
                                ColorFilter.mode(networkColor, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Төлбөрийн нөхцөл',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AccountSetting.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    padding: const EdgeInsets.all(8),
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: networkColor.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/wallet.svg',
                            colorFilter:
                                ColorFilter.mode(networkColor, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Данс тохиргоо',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(DistributionAreas.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    padding: const EdgeInsets.all(8),
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: networkColor.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/map.svg',
                            colorFilter:
                                ColorFilter.mode(networkColor, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'Чиглэл, бүсчлэл',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ReferenceInformationPage.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    padding: const EdgeInsets.all(8),
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: networkColor.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/bag.svg',
                            colorFilter:
                                ColorFilter.mode(networkColor, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Лавлах мэдээлэл',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
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
