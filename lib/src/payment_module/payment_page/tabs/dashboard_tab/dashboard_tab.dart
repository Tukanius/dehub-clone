import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/components/stast_card/stats_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/stats.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({Key? key}) : super(key: key);

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> with AfterLayoutMixin {
  User user = User();

  Map<String, double> data = {};
  List<Order> legend = [];
  Order confirmed = Order();
  bool isLoading = true;
  Map<String, dynamic> pieChart = {
    "B2B тооцооны орлого": 5,
    "SCF олголтын гүйлгээ": 3,
  };

  List<Color> colorList = [
    paymentColor,
    userColor,
    networkColor,
    partnerColor,
  ];

  @override
  afterFirstLayout(BuildContext context) {
    Map<String, double> pieData = {};
    pieChart.forEach((key, value) {
      pieData[key] = double.parse(value.toString());
      legend.add(
        Order(
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

  List<Stats> reviewData = [
    Stats(
      image: 'assets/svg/income_review.svg',
      name: 'ОРЛОГЫН ГҮЙЛГЭЭ ДҮН',
      amount: 238232000,
      percent: 12,
    ),
    Stats(
      image: 'assets/svg/expenditure_review.svg',
      name: 'ЗАРЛАГЫН ГҮЙЛГЭЭ ДҮН',
      amount: 238232000,
      percent: -12,
    ),
    Stats(
      image: 'assets/svg/finance_review.svg',
      name: 'САНХҮҮЖИЛТ АВСАН',
      amount: 238232000,
      percent: 12,
    ),
    Stats(
      image: 'assets/svg/paid_review.svg',
      name: 'САНХҮҮЖИЛТ ТӨЛСӨН',
      amount: 238232000,
      percent: -12,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: paymentColor,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: Text(
                        'Төлбөр тооцоо удирдлага',
                        style: TextStyle(
                            color: black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 120,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 15),
                        scrollDirection: Axis.horizontal,
                        itemCount: reviewData.length,
                        itemBuilder: (context, index) => StatsCard(
                          data: reviewData[index],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Text(
                            'Орлогын бүтэц',
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
                    PieChart(legend: legend, colorList: colorList, data: data),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          margin: const EdgeInsets.only(left: 15),
                          child: Text(
                            'Орлогын гүйлгээ',
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
                          BarSeries<Order, String>(
                            borderRadius: BorderRadius.circular(5),
                            pointColorMapper: (datum, index) =>
                                datum.name == "Зөвшөөрсөн"
                                    ? networkDashboard2
                                    : datum.name == "Илгээсэн"
                                        ? networkColor
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
