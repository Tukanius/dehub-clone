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
import 'package:dehub/components/pie_chart/network_pie_chart.dart';
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
  PageController pageController = PageController();
  int currentPage = 0;

  Map<String, double> dummy = {
    "ТОП 100": 5,
    "ТОП 50": 4,
    "ТОП 30": 3,
    "ТОП 20": 2,
    "ТОП 10": 1,
  };

  List<Business> dummyLegend = [
    Business(
      count: 5,
      profileName: 'ТОП 100',
    ),
    Business(
      count: 4,
      profileName: 'ТОП 50',
    ),
    Business(
      count: 3,
      profileName: 'ТОП 30',
    ),
    Business(
      count: 2,
      profileName: 'ТОП 20',
    ),
    Business(
      count: 1,
      profileName: 'ТОП 10',
    ),
  ];

  Business dummyInvitation = Business(
    start: DateTime.parse('2024-02-25'),
    end: DateTime.parse('2024-03-25'),
    stats: [
      Business(
        name: 'Илгээсэн',
        count: 3,
      ),
      Business(
        name: 'Зөвшөөрсөн',
        count: 2,
      ),
      Business(
        name: 'Цуцлагдсан',
        count: 4,
      ),
    ],
  );

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
  void initState() {
    pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

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
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        });
                      },
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: currentPage == 0
                            ? Colors.grey
                            : Colors.grey.shade300,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        });
                      },
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: currentPage == 1
                            ? Colors.grey
                            : Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ];
      },
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            Navigator.of(context)
                                .pushNamed(NetworkPartnerPage.routeName);
                          },
                          child: Container(
                            color: transparent,
                            padding: const EdgeInsets.symmetric(vertical: 5),
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
                    NetworkPieChart(
                      legend: dummyLegend,
                      colorList: colorList,
                      data: dummy,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                NetworkHorizontalChart(
                  index: 2,
                  data: dummyInvitation,
                  labelText: 'Танайд ирсэн',
                ),
                const SizedBox(
                  height: 10,
                ),
                NetworkHorizontalChart(
                  index: 3,
                  labelText: 'Танай илгээсэн',
                  data: dummyInvitation,
                ),
              ],
            ),
          ),
          isLoading == true
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
                            NetworkPieChart(
                              legend: legend,
                              colorList: colorList,
                              data: data,
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
                ),
        ],
      ),
    );
  }
}
