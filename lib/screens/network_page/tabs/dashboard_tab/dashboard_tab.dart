import 'package:dehub/api/business_api.dart';
import 'package:dehub/models/business.dart';
import 'package:dehub/screens/distribution_areas/distribution_areas.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/reference_information_page/reference_information_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/partner_page/partner_page.dart';
import 'package:dehub/screens/client_staffs/client_staffs.dart';
import 'package:dehub/screens/payment_terms/payment_terms.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pie_chart/pie_chart.dart' as Chart;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';

class DashboardTab extends StatefulWidget {
  final Function()? callback;
  const DashboardTab({
    Key? key,
    this.callback,
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
    return Scaffold(
      body: SingleChildScrollView(
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
                              color: networkColor,
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
                              color: networkColor,
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
                    onTap: () {},
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
                              color: networkColor,
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
                              color: networkColor,
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
                    onTap: () {},
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
                              color: networkColor,
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
                              color: networkColor,
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
                              color: networkColor,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Navigator.of(context)
                                  .pushNamed(NetworkPartnerPage.routeName);
                            },
                            child: Container(
                              color: transparent,
                              padding: const EdgeInsets.symmetric(vertical: 5),
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
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 32),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: white,
                        ),
                        child: Column(
                          children: [
                            Chart.PieChart(
                              dataMap: data,
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartLegendSpacing: 35,
                              chartRadius: 220,
                              colorList: colorList,
                              initialAngleInDegree: 0,
                              chartType: Chart.ChartType.ring,
                              ringStrokeWidth: 50,
                              legendOptions: const Chart.LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: Chart.LegendPosition.bottom,
                                showLegends: false,
                                legendShape: BoxShape.circle,
                                legendTextStyle: TextStyle(fontSize: 10),
                              ),
                              chartValuesOptions:
                                  const Chart.ChartValuesOptions(
                                showChartValueBackground: false,
                                showChartValues: false,
                                showChartValuesInPercentage: false,
                                showChartValuesOutside: false,
                              ),
                            ),
                            SizedBox(
                              height: 37,
                            ),
                            Column(
                              children: legend
                                  .map(
                                    (data) => Container(
                                      margin: const EdgeInsets.only(bottom: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                              color: colorList.elementAt(
                                                  legend.indexOf(data)),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: Text(
                                                '${data.count}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${(100 * data.count! / legend.fold(0, (previousValue, element) => previousValue + element.count!)).toStringAsFixed(0)}%',
                                              style: TextStyle(
                                                color: grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 11,
                                            child: Text(
                                              '${data.profileName}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: grey2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: Text(
                              'Танай илгээсэн',
                              style: TextStyle(
                                color: black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: transparent,
                              padding: const EdgeInsets.symmetric(vertical: 5),
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
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: grey,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${DateFormat("yyyy-MM-dd").format(sent.start!)} - ',
                            style: TextStyle(
                              color: grey,
                              fontSize: 12,
                            ),
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: grey,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${DateFormat("yyyy-MM-dd").format(sent.start!)}',
                            style: TextStyle(
                              color: grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 180,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: white,
                        ),
                        child: SfCartesianChart(
                          series: <ChartSeries>[
                            BarSeries<Business, String>(
                              borderRadius: BorderRadius.circular(5),
                              pointColorMapper: (datum, index) =>
                                  datum.name == "Зөвшөөрсөн"
                                      ? networkDashboard2
                                      : datum.name == "Илгээсэн"
                                          ? networkColor
                                          : grey2,
                              dataSource: sent.stats!,
                              xValueMapper: (gdp, _) => gdp.name,
                              yValueMapper: (gdp, _) => gdp.count,
                            )
                          ],
                          primaryXAxis: CategoryAxis(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: Text(
                              'Танайд ирсэн',
                              style: TextStyle(
                                color: black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: transparent,
                              padding: const EdgeInsets.symmetric(vertical: 5),
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
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: grey,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '2023-10-10 - ',
                            style: TextStyle(
                              color: grey,
                              fontSize: 12,
                            ),
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: grey,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '2023-10-17',
                            style: TextStyle(
                              color: grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 180,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: white,
                        ),
                        child: SfCartesianChart(
                          series: <ChartSeries>[
                            BarSeries<Business, String>(
                              borderRadius: BorderRadius.circular(5),
                              pointColorMapper: (datum, index) =>
                                  datum.name == "Зөвшөөрсөн"
                                      ? networkDashboard2
                                      : datum.name == "Илгээсэн"
                                          ? networkColor
                                          : grey2,
                              dataSource: received.stats!,
                              xValueMapper: (gdp, _) => gdp.name,
                              yValueMapper: (gdp, _) => gdp.count,
                            )
                          ],
                          primaryXAxis: CategoryAxis(),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
