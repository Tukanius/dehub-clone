import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_page/avaible_funding_page.dart';
import 'package:dehub/src/finance_module/screens/funding_request_page/funding_request_page.dart';
import 'package:dehub/src/finance_module/screens/recalled_page/recalled_page.dart';
import 'package:dehub/src/finance_module/screens/repayment_page/repayment_page.dart';
import 'package:dehub/src/finance_module/screens/received_funding_page/received_funding_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashBoardTab extends StatefulWidget {
  const DashBoardTab({super.key});

  @override
  State<DashBoardTab> createState() => _DashBoardTabState();
}

class _DashBoardTabState extends State<DashBoardTab> with AfterLayoutMixin {
  Map<String, double> data = {};
  List<Finance> legend = [];
  Finance confirmed = Finance();
  bool isLoading = true;
  Map<String, dynamic> pieChart = {
    "Санхүүжилт авсан": 3,
    "Санхүүжилт хүссэн": 3,
    "Олголт хүлээж буй": 3,
    "Боломжит лимит": 3,
    "Үлдэгдэл лимит": 3,
  };

  List<Color> colorList = [
    orderColor,
    pieBlue,
    pieYellow,
    pieOrange,
    pieRed,
  ];

  @override
  afterFirstLayout(BuildContext context) {
    Map<String, double> pieData = {};
    pieChart.forEach((key, value) {
      pieData[key] = double.parse(value.toString());
      legend.add(
        Finance(
          count: value,
          profileName: key,
        ),
      );
    });
    setState(() {
      data = pieData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: Text(
              'Санхүүжилт удирдлага',
              style: TextStyle(
                  color: black, fontSize: 24, fontWeight: FontWeight.bold),
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
                        .pushNamed(AvaibleFundingPage.routeName);
                  },
                  boxColor: financingColor.withOpacity(0.1),
                  padding: 10,
                  labelText: 'Боломжит нэхэмжлэх',
                  svgColor: financingColor,
                  svg: 'assets/svg/available_invoice.svg',
                ),
                DashboardCard(
                  onClick: () {
                    Navigator.of(context)
                        .pushNamed(FundingRequestPage.routeName);
                  },
                  boxColor: financingColor.withOpacity(0.1),
                  padding: 10,
                  labelText: 'Санхүүжилт хүсэлт',
                  svgColor: financingColor,
                  svg: 'assets/svg/sanhuujiltS.svg',
                ),
                DashboardCard(
                  onClick: () {
                    Navigator.of(context)
                        .pushNamed(ReceivedFundingPage.routeName);
                  },
                  boxColor: financingColor.withOpacity(0.1),
                  padding: 10,
                  labelText: 'Авсан санхүүжилт',
                  svgColor: financingColor,
                  svg: 'assets/svg/camera.svg',
                ),
                DashboardCard(
                  onClick: () {
                    Navigator.of(context).pushNamed(RePayment.routeName);
                  },
                  boxColor: financingColor.withOpacity(0.1),
                  padding: 10,
                  labelText: 'Эргэн төлөлтүүд',
                  svgColor: financingColor,
                  svg: 'assets/svg/payback.svg',
                ),
                DashboardCard(
                  onClick: () {
                    Navigator.of(context).pushNamed(ReCalledPage.routeName);
                  },
                  boxColor: financingColor.withOpacity(0.1),
                  padding: 10,
                  labelText: 'Буцаан дуудсан',
                  svgColor: financingColor,
                  svg: 'assets/svg/return.svg',
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
                    color: financingColor,
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
                            'Хөтөлбөрийн лимит',
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
                                    color: financingColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: financingColor,
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
                                    color: financingColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: financingColor,
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
                          '${DateFormat("yyyy-MM-dd").format(DateTime.now())} - ',
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
                          '${DateFormat("yyyy-MM-dd").format(DateTime.now())}',
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
                          BarSeries<Finance, String>(
                            borderRadius: BorderRadius.circular(5),
                            pointColorMapper: (datum, index) =>
                                datum.profileName == "Зөвшөөрсөн"
                                    ? networkDashboard2
                                    : datum.profileName == "Илгээсэн"
                                        ? financingColor
                                        : grey2,
                            dataSource: legend,
                            xValueMapper: (gdp, _) => gdp.profileName,
                            yValueMapper: (gdp, _) => gdp.count,
                          )
                        ],
                        primaryXAxis: CategoryAxis(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
